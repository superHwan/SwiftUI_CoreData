//
//  CoreDataStack.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

import CoreData

class CoreDataStack: ObservableObject {
    let persistentContainer: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "ParkDataModel")
        
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "dev/null")!
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        
        if forPreview {
            Task {
                do {
                    try await setupMockData()
//                    try await ParkDataImporter().addParkMockData(to: managedObjectContext)
                } catch {
                    print("Failed to add mock data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static var shared: CoreDataStack {
        sharedParkContainer
    }
    
    private static var sharedParkContainer: CoreDataStack {
        #if DEBUG
        CoreDataStack(forPreview: true)
        #else
        CoreDataStack()
        #endif
    }
}
