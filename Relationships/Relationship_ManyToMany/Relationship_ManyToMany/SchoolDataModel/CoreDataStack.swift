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
    
    // SchoolDataModel 堆栈（Many-To-Many）
    lazy var schoolPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SchoolDataModel")
        container.viewContext.undoManager = UndoManager() // 配置给iOS 使用
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store for SchoolDataModel: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var schoolManagedObjectContext: NSManagedObjectContext {
        schoolPersistentContainer.viewContext
    }
}
