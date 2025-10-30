//
//  CoreDataStack.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/24.
//

import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    let modelName: String
    
    init(modelName: String = "TasksDataModel") {
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    
    // 如果使用单例模式，需启用该init，并添加额外代码
//    let inMemory: Bool
//    public init(_ modelName: String = "TasksDataModel", inMemory: Bool = false) {
//        self.modelName = modelName
//        self.inMemory = inMemory
//    }
}
