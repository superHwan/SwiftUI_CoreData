//
//  CoreDataStack.swift
//  Relationships
//
//  Created by Sanny on 2025/11/4.
//

import CoreData
import SwiftUI

class CoreDataStack: ObservableObject {
    
    let persistentContainer: NSPersistentContainer
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "AutosDataModel")
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store for AutosDataModel: \(error.localizedDescription)")
            }
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        if forPreview {
            Task {
                do {
                    try await AutosDataImporter.addMockData(to: persistentContainer.viewContext)
                } catch {
                    handleDataInitError(error)
                }
            }
        }
        // 欠缺：打包后用的初始数据 importAutosData
    }
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    static var shared: CoreDataStack {
        return sharedAutosCoreDataStack
    }
    
    private static var sharedAutosCoreDataStack: CoreDataStack = {
        #if DEBUG
            return CoreDataStack(forPreview: true)
        #else
            return CoreDataStack()
        #endif
    }()
}

extension CoreDataStack {
    private func handleDataInitError(_ error: Error) {
        CoreDataStack.shared.managedObjectContext.rollback()
        
        #if DEBUG
        // 开发阶段：中断程序，暴露问题
        fatalError("Failed to import autos data: \(error.localizedDescription)")
        #else
        // 生产环境：记录日志
        print("Failed to import autos data, restored to initial state: \(error.localizedDescription)")
        // 自行添加提示/重试逻辑
        #endif
    }
}
