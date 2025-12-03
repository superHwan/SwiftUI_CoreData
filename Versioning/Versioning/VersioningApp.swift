//
//  VersioningApp.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

import SwiftUI

@main
struct VersioningApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
        }
    }
}
