//
//  CoreDataStack.swift
//  Transforming
//
//  Created by Sanny on 2025/12/4.
//

import CoreData

class CoreDataStack: ObservableObject {
    let persistentContainer: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(forPreview: Bool = false) {
        AppDataTransformer.register() // 先注册转换器
        persistentContainer = NSPersistentContainer(name: "MotorcyclesDataModel")
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "dev/null")!
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        
        if forPreview {
            // 导入模拟数据
            Task {
                do {
                    try await MockDataImporter().addMotorcycleMockData(to: managedObjectContext)
                } catch {
                    print("Failed to load the mock data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static var shared: CoreDataStack {
        sharedMotocyclesContainer
    }
    
    private static var sharedMotocyclesContainer: CoreDataStack {
        #if DEBUG
        CoreDataStack(forPreview: true)
        #else
        CoreDataStack()
        #endif
    }
}
