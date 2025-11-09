//
//  CoreDataStack.swift
//  Relationship_SelfReferencing
//
//  Created by Sanny on 2025/11/9.
//

import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WorkerDataModel")
//        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}
