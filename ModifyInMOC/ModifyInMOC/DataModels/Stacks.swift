//
//  Stacks.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/28.
//
import CoreData

extension CoreDataStack {
    static var previewInMemory: NSManagedObjectContext {
        get {
            let persistentContainer = NSPersistentContainer(name: "TasksDataModel")
            persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
            persistentContainer.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Failed to load the persistent store: \(error.localizedDescription)")
                }
            }
            addMockData(moc: persistentContainer.viewContext)
            return persistentContainer.viewContext
        }
    }
    
    /// 预览处创建模拟实体的专用上下文
    static var singleEntityForPreview: NSManagedObjectContext {
        let persistentContainer = NSPersistentContainer(name: "TasksDataModel")
        persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store: \(error.localizedDescription)")
            }
        }
        return persistentContainer.viewContext
    }
    
    
    static func addMockData(moc: NSManagedObjectContext) {
        let tasks: [(taskName: String, year: Int, month: Int, day: Int, priority: Int16, done: Bool)] = [
            ("阅读 20min", 2025, 9, 24, 3, true),
            ("静坐 15min", 2025, 10, 25, 2, false),
            ("完成练习10", 2025, 11, 1, 3, false),
            ("月总结", 2025, 10, 30, 1, false)
        ]
        
        // 配置属性
        for taskData in tasks {
            let task = TaskEntity(context: moc)
            task.done = taskData.done
            task.dueDate = Calendar.current.date(from: DateComponents(year: taskData.year, month: taskData.month, day: taskData.day))
            task.priority = taskData.priority
            task.taskName = taskData.taskName
        }
        
        try? moc.save()
    }
}

extension CoreDataStack {
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}
