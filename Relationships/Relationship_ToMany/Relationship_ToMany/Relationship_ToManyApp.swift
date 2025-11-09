//
//  Relationship_ToManyApp.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// .environment需要应用于视图层级的根部（ @main 或 ContentView的根）

import SwiftUI

@main
struct Relationship_ToManyApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.autosManagedObjectContext)
                .task {
                    await AutosDataImporter.importAutosData(to: coreDataStack.autosManagedObjectContext)
                }
        }
    }
}
