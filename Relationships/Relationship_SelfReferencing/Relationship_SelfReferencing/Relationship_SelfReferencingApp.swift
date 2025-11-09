//
//  Relationship_SelfReferencingApp.swift
//  Relationship_SelfReferencing
//
//  Created by Sanny on 2025/11/7.
//

import SwiftUI

@main
struct Relationship_SelfReferencingApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
                .task {
                    do {
                        try await WorkerDataInitializer.importWorkerData(to: coreDataStack.managedObjectContext)
                    } catch {
                        handleInitializationError(error)
                    }
                }
        }
    }
    
    private func handleInitializationError(_ error: Error) {
        #if DEBUG
            // 开发阶段：中断程序，暴露问题
            fatalError("Failed to import workers data: \(error.localizedDescription)")
        #else
            // 生产环境：记录日志
            print("Failed to import workers data, restored to initial state: \(error.localizedDescription)")
            // 可自行添加提示/重试逻辑
        #endif
    }
}
