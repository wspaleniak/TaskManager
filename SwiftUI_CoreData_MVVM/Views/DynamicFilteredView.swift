//
//  DynamicFilteredView.swift
//  SwiftUI_CoreData_MVVM
//
//  Created by Wojciech Spaleniak on 02/01/2023.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject {
    
    // MARK: Core Data Request
    @FetchRequest var request: FetchedResults<T>
    let content: (T) -> Content
    
    // MARK: Building custom ForEach which will give CoreData Object to build View
    init(currentTab: String, @ViewBuilder content: @escaping (T) -> Content) {
        
        // MARK: Predicate to filter current date Tasks
        let calendar = Calendar.current
        var predicate: NSPredicate!
        
        if currentTab == "Today" {
            let today = calendar.startOfDay(for: Date())
            let tommorow = calendar.date(byAdding: .day, value: 1, to: today)!
            
            // Filter Key
            let filterKey = "deadline"
            
            // This will fetch tasks between today and tommorow which is 24HRS
            // 0-false, 1-true
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today, tommorow, 0])
            
        } else if currentTab == "Upcoming" {
            let today = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!)
            let tommorow = Date.distantFuture
            
            // Filter Key
            let filterKey = "deadline"
            
            // This will fetch tasks between today and tommorow which is 24HRS
            // 0-false, 1-true
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today, tommorow, 0])
            
        } else if currentTab == "Failed" {
            let today = calendar.startOfDay(for: Date())
            let past = Date.distantPast
            
            // Filter Key
            let filterKey = "deadline"
            
            // This will fetch tasks between today and tommorow which is 24HRS
            // 0-false, 1-true
            predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [past, today, 0])
            
        } else if currentTab == "Done" {
            predicate = NSPredicate(format: "isCompleted == %i", argumentArray: [1])
        }
        
        // Initializing Request with NSPredicate
        // Adding Sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.deadline, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        Group {
            if request.isEmpty {
                Text("No tasks found!")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .offset(y: 200)
            } else {
                ForEach(request, id: \.objectID) { object in
                    self.content(object)
                }
            }
        }
    }
}
