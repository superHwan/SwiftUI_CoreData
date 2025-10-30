//
//  ModifyInMOCApp.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/24.
//

import SwiftUI

@main
struct ModifyInMOCApp: App {
    @StateObject private var coreDataStack = CoreDataStack()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
                .task { // 所有视图共享一份数据，故应用入口处导入
                    do {
                        try await TaskDataImporter.importTasks(to: coreDataStack.managedObjectContext)
                    } catch {
                        fatalError("Failed to load init datas: \(error.localizedDescription)")
                    }
                }
        }
    }
}
