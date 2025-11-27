//
//  CoreDataStack.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/21.
//

import CoreData

class CoreDataStack: ObservableObject {
    
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext // 专用的私有队列
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "UsersDataModel")
        
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        
        backgroundContext = persistentContainer.newBackgroundContext()
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true // 同步到主上下文
        
        if forPreview {
            Task {
                do {
                    // 绝对路径
//                    try await UserService().fetchJSONFromAbsolutePath()
                    // 程序的资源文件
                    try await UserService().fetchUsersFromLocal()
                    // 网络链接
//                    try await UserService().fetchFromAPI()
                } catch {
                    print("Failed to load the mock data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static var shared: CoreDataStack {
        return sharedUsersCoreDataStack
    }
    
    private static var sharedUsersCoreDataStack: CoreDataStack = {
        #if DEBUG
        return CoreDataStack(forPreview: true)
        #else
        return CoreDataStack()
        #endif
    }()
}
