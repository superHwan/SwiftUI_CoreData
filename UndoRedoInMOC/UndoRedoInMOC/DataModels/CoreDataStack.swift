//
//  CoreDataStack.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//

import CoreData

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TasksDataModel")
        container.viewContext.undoManager = UndoManager() // iOS需配置，以使用 undo()
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
