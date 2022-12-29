//
//  TaskViewModel.swift
//  SwiftUI_CoreData_MVVM
//
//  Created by Wojciech Spaleniak on 27/12/2022.
//

import Foundation
import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    
    @Published var currentTab: String = "Today"
    
    // MARK: New Task properties
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
    
    // MARK: Adding Task to Core Data
    func addTask(context: NSManagedObjectContext) -> Bool {
        let task = Task(context: context)
        task.title = self.taskTitle
        task.color = self.taskColor
        task.deadline = self.taskDeadline
        task.type = self.taskType
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
    // MARK: Reset Data
    func resetTaskData() {
        self.taskTitle = ""
        self.taskColor = "Yellow"
        self.taskDeadline = Date()
        self.taskType = "Basic"
    }
}
