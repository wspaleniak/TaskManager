//
//  Home.swift
//  SwiftUI_CoreData_MVVM
//
//  Created by Wojciech Spaleniak on 27/12/2022.
//

import SwiftUI

struct Home: View {
    
    @StateObject var taskViewModel: TaskViewModel = .init()
    
    // MARK: Matched Geometry Namespace
    @Namespace var animation
    
    // MARK: Fetch Tasks
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(
            keyPath: \Task.deadline,
            ascending: false)],
        predicate: nil,
        animation: .easeInOut)
    var tasks: FetchedResults<Task>
    
    // MARK: Environment Values
    @Environment(\.self) var env
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome Back!")
                        .font(.callout)
                        .fontWeight(.semibold)
                    Text("Here's Update Today.")
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                
                // MARK: Custom Segmented Bar
                CustomSegmentedBar()
                    .padding(.top, 5)
                
                // MARK: Task View
                CustomTaskView()
                    .padding(.top, 10)
                
                Rectangle()
                    .fill(.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            // MARK: Add button
            Button {
                self.taskViewModel.openEditTask.toggle()
            } label: {
                Label {
                    Text("Add Task")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(.black, in: Capsule())
            }
            // MARK: Linear gradient BG
            .padding(.top, 20)
            .frame(maxWidth: .infinity)
            .background {
                LinearGradient(colors: [
                    .white.opacity(0.00),
                    .white.opacity(0.15),
                    .white.opacity(0.30),
                    .white.opacity(0.45),
                    .white.opacity(0.75),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            }
        }
        .fullScreenCover(isPresented: self.$taskViewModel.openEditTask) {
            self.taskViewModel.resetTaskData()
        } content: {
            AddNewTask()
                .environmentObject(self.taskViewModel)
        }
    }
    
    // MARK: Task View
    @ViewBuilder
    func CustomTaskView() -> some View {
        LazyVStack(spacing: 10) {
            // MARK: Custom Filtered Request View
            DynamicFilteredView(currentTab: self.taskViewModel.currentTab) { (task: Task) in
                CustomTaskRowView(task: task)
            }
        }
        .padding(.top, 20)
    }
    
    // MARK: Task Row View
    @ViewBuilder
    func CustomTaskRowView(task: Task) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(task.type ?? "")
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                Spacer()
                
                // MARK: Edit Button only for Non Completed Tasks
                if !task.isCompleted && self.taskViewModel.currentTab != "Failed" {
                    Button {
                        self.taskViewModel.editTask = task
                        self.taskViewModel.openEditTask = true
                        self.taskViewModel.setupTask()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                    }
                }
            }
            
            Text(task.title ?? "")
                .font(.title2.bold())
                .foregroundColor(.black)
                .padding(.vertical, 10)
            
            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    } icon: {
                        Image(systemName: "calendar")
                            .foregroundColor(.black)
                    }
                    .font(.caption)
                    
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                            .foregroundColor(.black)
                    }
                    .font(.caption)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if !task.isCompleted && self.taskViewModel.currentTab != "Failed" {
                    Button {
                        // MARK: Update Core Data
                        task.isCompleted.toggle()
                        try? self.env.managedObjectContext.save()
                    } label: {
                        Image(systemName: "circle")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                } else {
                    Button {
                        // MARK: Update Core Data
                        task.isCompleted.toggle()
                        try? self.env.managedObjectContext.save()
                    } label: {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(task.color ?? "Yellow").opacity(0.75))
        }
    }
    
    // MARK: Custom Segmented Bar
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        let tabs = ["Today", "Upcoming", "Done", "Failed"]
        HStack(spacing: 10) {
            ForEach(tabs, id: \.self) { tab in
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(self.taskViewModel.currentTab == tab ? .white : .black )
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background {
                        if self.taskViewModel.currentTab == tab {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        } else {
                            Capsule()
                                .strokeBorder(.black)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            self.taskViewModel.currentTab = tab
                        }
                    }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
