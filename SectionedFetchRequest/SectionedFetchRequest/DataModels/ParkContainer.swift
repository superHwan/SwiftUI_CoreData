//
//  ParkContainer.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/23.
//

import CoreData

@Observable
class ParkContainer {
    private let persistentContainer: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: "ParksDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the persistent store: ", error.localizedDescription)
            }
        }
    }
    
    func save() {
        guard managedObjectContext.hasChanges else { return }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
}
