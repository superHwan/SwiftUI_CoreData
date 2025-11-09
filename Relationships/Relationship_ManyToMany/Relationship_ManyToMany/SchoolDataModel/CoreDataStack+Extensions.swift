//
//  CoreDataStack+Extensions.swift
//  Relationships
//
//  Created by Sanny on 2025/11/5.
//

import CoreData
import SwiftUI

extension CoreDataStack {
    /// SchoolDataModel 预览用
    static var previewForSchoolDataModel: NSManagedObjectContext {
        let persistentContainer = NSPersistentContainer(name: "SchoolDataModel")
        persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store for preview: \(error.localizedDescription)")
            }
        }
        SchoolDataInitializer.addMockDataToSchool(moc: persistentContainer.viewContext)
        return persistentContainer.viewContext
    }
    
    /// 预览处 创建单个模拟实体的上下文
    static var singleEntityForPreview: NSManagedObjectContext {
        let persistentContainer = NSPersistentContainer(name: "SchoolDataModel")
        persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        return persistentContainer.viewContext
    }
}
