//
//  CoreDataStack.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//

import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack() // 单例
    
    let modelName: String
    
    init(modelName: String = "CountriesDataModel") {
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        
        // 合并策略：持久化数据和内存数据改变且冲突，保留内存数据
//        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
