//
//  ValidationApp.swift
//  Validation
//
//  Created by Sanny on 2025/11/27.
//

import SwiftUI

@main
struct ValidationApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
        }
    }
}
