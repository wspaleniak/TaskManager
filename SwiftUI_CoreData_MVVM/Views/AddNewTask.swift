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
    
    // MARK: Matched Geometry Namespace
    @Namespace var animation
    
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
                .padding(.vertical, 10)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Task Type")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                CustomSegmentedBarForTaskType()
                    .padding(.top, 8)
            }
            
            Divider()
                .padding(.vertical, 10)
            
            // MARK: Save Button
            Button {
                // ACTION?
            } label: {
                Text("Save Task")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .foregroundColor(.white)
                    .background {
                        Capsule().fill(.black)
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
            .disabled(self.taskViewModel.taskTitle == "")
            .opacity(self.taskViewModel.taskTitle == "" ? 0.6 : 1.0)

        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
    
    // MARK: Custom Segmented Bar For Task Type
    @ViewBuilder
    func CustomSegmentedBarForTaskType() -> some View {
        let taskTypes: [String] = ["Basic", "Urgent", "Important"]
        HStack(spacing: 10) {
            ForEach(taskTypes, id: \.self) { type in
                Text(type)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(self.taskViewModel.taskType == type ? .white : .black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background {
                        if self.taskViewModel.taskType == type {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TYPE", in: animation)
                        } else {
                            Capsule()
                                .strokeBorder(.black)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            self.taskViewModel.taskType = type
                        }
                    }
            }
        }
    }
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask()
            .environmentObject(TaskViewModel())
    }
}
