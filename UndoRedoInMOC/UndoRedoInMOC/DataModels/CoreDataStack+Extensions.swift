//
//  CoreDataStack+Extensions.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
import CoreData

extension CoreDataStack {
    public static var previewInMemory: NSManagedObjectContext {
        let container = NSPersistentContainer(name: "TasksDataModel")
        container.viewContext.undoManager = UndoManager() // 不配置，则在iOS使用undo()无效
        container.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store for preview: \(error.localizedDescription)")
            }
        }
        addMockData(moc: container.viewContext)
        return container.viewContext
    }
    
    private static func addMockData(moc: NSManagedObjectContext) {
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
            task.name = taskData.taskName
        }
        
        try? moc.save()
    }
}
