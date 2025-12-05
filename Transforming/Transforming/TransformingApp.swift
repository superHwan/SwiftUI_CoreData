//
//  TransformingApp.swift
//  Transforming
//
//  Created by Sanny on 2025/12/3.
//

import SwiftUI

@main
struct TransformingApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
        }
    }
}
