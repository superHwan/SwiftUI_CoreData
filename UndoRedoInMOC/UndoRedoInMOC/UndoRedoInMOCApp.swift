//
//  UndoRedoInMOCApp.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//

import SwiftUI

@main
struct UndoRedoInMOCApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
                .task {
                    do {
                        try await TaskDataImporter.importTasks(to: coreDataStack.managedObjectContext)
                    } catch {
                        fatalError("Failed to load init data: \(error.localizedDescription)")
                    }
                }
        }
    }
}
