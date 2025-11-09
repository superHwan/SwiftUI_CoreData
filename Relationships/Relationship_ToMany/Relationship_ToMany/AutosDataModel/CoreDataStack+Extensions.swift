//
//  CoreDataStack+Extensions.swift
//  Relationships
//
//  Created by Sanny on 2025/11/5.
//

import CoreData
import SwiftUI

extension CoreDataStack {
    /// 预览用
    static var previewInMemory: NSManagedObjectContext {
        get {
            let persistentContainer = NSPersistentContainer(name: "AutosDataModel")
            persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
            persistentContainer.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Failed to load the persistent store for preview: \(error.localizedDescription)")
                }
            }
            AutosDataImporter.addMockData(moc: persistentContainer.viewContext)
            return persistentContainer.viewContext
        }
    }
}
