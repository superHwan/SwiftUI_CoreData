//
//  CoreDataStack.swift
//  Relationships
//
//  Created by Sanny on 2025/11/4.
//
// 尝试使用单例模式

import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    // AutosDataModel 堆栈（To-Many）
    lazy var autosPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AutosDataModel")
        container.viewContext.undoManager = UndoManager() // 配置给iOS 使用
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store for AutosDataModel: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var autosManagedObjectContext: NSManagedObjectContext {
        autosPersistentContainer.viewContext
    }
}
