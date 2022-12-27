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
                
                CustomSegmentedBar()
                    .padding(.top, 5)
                
                // MARK: Task View
                // Later will come
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            // MARK: Add button
            Button {
                // ACTION?
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
                    .white.opacity(0.05),
                    .white.opacity(0.40),
                    .white.opacity(0.70),
                    .white
                ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            }
        }
    }
    
    // MARK: Custom Segmented Bar
    @ViewBuilder
    func CustomSegmentedBar() -> some View {
        let tabs = ["Today", "Upcoming", "Task Done"]
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