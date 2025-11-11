//
//  CoreDataStack+Extensions.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/11.
//
import CoreData

extension CoreDataStack {
    static var previewInMemory: NSManagedObjectContext {
        get {
            let container = NSPersistentContainer(name: "BeachesDataModel")
            container.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
            container.loadPersistentStores { _, error in
                if let error = error {
                    print("Failed to load for preview: \(error.localizedDescription)")
                }
            }
            BeachesDataInitializer.addMockDataToBeaches(to: container.viewContext)
            return container.viewContext
        }
    }
}
