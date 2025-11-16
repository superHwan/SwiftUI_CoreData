//
//  ConCurrencyApp.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/11.
//

import SwiftUI

@main
struct ConCurrencyApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
                .task {
                    do {
                        try await CountryDataImporter.importCountryData(to: coreDataStack.managedObjectContext)
                    } catch {
                        handleDataInitError(error)
                    }
                }
        }
    }
    
    private func handleDataInitError(_ error: Error) {
        #if DEBUG
        // 开发阶段：中断程序，暴露问题
        fatalError("Failed to load country data: \(error.localizedDescription)")
        #else
        // 生产环境：记录日志
        print("Failed to load country data: \(error.localizedDescription)")
        // 可自行添加提示/重试逻辑
        #endif
    }
}
