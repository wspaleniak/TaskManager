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
}
