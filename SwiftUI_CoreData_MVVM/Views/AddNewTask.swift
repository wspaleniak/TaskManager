//
//  AddNewTask.swift
//  SwiftUI_CoreData_MVVM
//
//  Created by Wojciech Spaleniak on 27/12/2022.
//

import SwiftUI

struct AddNewTask: View {
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    // MARK: All Environment Values in one Variable
    @Environment(\.self) var env
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Edit Task")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }

                }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Color")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                // MARK: Sample Card Colors
                let colors: [String] = ["Yellow", "Green", "Blue", "Purple", "Red", "Orange"]
                
                HStack(spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(Color(color))
                            .frame(width: 25, height: 25)
                            .background {
                                if self.taskViewModel.taskColor == color {
                                    Circle()
                                        .strokeBorder(.gray)
                                        .padding(-3)
                                }
                            }
                            .contentShape(Circle())
                            .onTapGesture {
                                self.taskViewModel.taskColor = color
                            }
                    }
                }
                .padding(.top, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)
            
            Divider()
                .padding(.vertical, 10)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Deadline")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(self.taskViewModel.taskDeadline.formatted(date: .abbreviated, time: .omitted) + ", " + self.taskViewModel.taskDeadline.formatted(date: .omitted, time: .shortened))
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    // ACTION?
                } label: {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                }
            }
            
            Divider()
                .padding(.vertical, 10)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Title")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                TextField("Enter task title", text: self.$taskViewModel.taskTitle)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
            }
            
            Divider()
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}
