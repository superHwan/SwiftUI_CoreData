//
//  CoreDataStack.swift
//  Validation
//
//  Created by Sanny on 2025/11/27.
//

import CoreData

class CoreDataStack: ObservableObject {
    let persistentContainer: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "BookDataModel")
        
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        
        if forPreview {
            Task {
                do {
                    try await BookMockDataImporter().addMockData(to: managedObjectContext)
                } catch {
                    print("Failed to add mock data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static var shared: CoreDataStack {
        return sharedBookContainer
    }
    
    private static var sharedBookContainer: CoreDataStack {
        #if DEBUG
        return CoreDataStack(forPreview: true)
        #else
        return CoreDataStack()
        #endif
    }
}
