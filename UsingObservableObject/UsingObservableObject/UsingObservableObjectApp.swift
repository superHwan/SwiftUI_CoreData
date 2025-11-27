//
//  UsingObservableObjectApp.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/20.
//

import SwiftUI

@main
struct UsingObservableObjectApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
        }
    }
}
