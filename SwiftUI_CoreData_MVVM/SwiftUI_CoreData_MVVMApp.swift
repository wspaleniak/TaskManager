//
//  SwiftUI_CoreData_MVVMApp.swift
//  SwiftUI_CoreData_MVVM
//
//  Created by Wojciech Spaleniak on 27/12/2022.
//

import SwiftUI

@main
struct SwiftUI_CoreData_MVVMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
