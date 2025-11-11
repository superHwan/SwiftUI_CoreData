//
//  DeriveAttributeApp.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/9.
//

import SwiftUI

@main
struct DeriveAttributeApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
                .task {
                    do {
                        try await BeachesDataInitializer.importBeachesData(to: coreDataStack.managedObjectContext)
                    } catch {
                        handleInitializationError(error)
                    }
                }
        }
    }
    
    private func handleInitializationError(_ error: Error) {
        #if DEBUG
            // 开发阶段：中断程序，暴露问题
            fatalError("Failed to import beaches data: \(error.localizedDescription)")
        #else
            // 生产环境：记录日志
            print("Failed to import workers data, restored to initial state: \(error.localizedDescription)")
            // 可自行添加提示/重试逻辑
        #endif
    }
}
