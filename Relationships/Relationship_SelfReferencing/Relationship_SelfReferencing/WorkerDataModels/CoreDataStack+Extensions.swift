//
//  CoreDataStack+Extensions.swift
//  Relationship_SelfReferencing
//
//  Created by Sanny on 2025/11/9.
//
import CoreData

extension CoreDataStack {
    static var previewForWorkerDataModel: NSManagedObjectContext {
        let persistentContainer = NSPersistentContainer(name: "WorkerDataModel")
        persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store for preview: \(error.localizedDescription)")
            }
        }
        WorkerDataInitializer.addMockDataToWorker(to: persistentContainer.viewContext)
        return persistentContainer.viewContext
    }
}
