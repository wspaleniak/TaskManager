//
//  ContentView.swift
//  SwiftUI_CoreData_MVVM
//
//  Created by Wojciech Spaleniak on 27/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("Task Manager", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
