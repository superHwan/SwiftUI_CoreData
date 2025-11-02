//
//  TaskDataImporter.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
// 视图间会共享一份数据

import CoreData
import SwiftUI

internal enum TaskDataImporter {
    static func importTasks(to managedObjectContext: NSManagedObjectContext) async throws {
        
        // 仅在第一次运行时将数据写入数据库，第一次运行后将 alreadyRun 设为true
        guard UserDefaults.standard.bool(forKey: "alreadyRun") == false else {
            return
        }
        
        UserDefaults.standard.set(true, forKey: "alreadyRun")
        
        try await managedObjectContext.perform {
            // 数据源
            let tasks: [(name: String, year: Int, month: Int, day: Int, priority: Int16, done: Bool)] = [
                ("CoreData 初始数据导入", 2025, 9, 24, 3, true),
                ("数据导入方法测试用例编写", 2025, 10, 25, 2, false),
                ("AVL 树的 Swift 实现", 2025, 11, 1, 3, false),
                ("文档更新", 2025, 11, 10, 1, false),
                ("了解 SwiftData", 2025, 12, 20, 3, false)
            ]
            
            // 配置属性
            for taskData in tasks {
                let task = TaskEntity(context: managedObjectContext)
                task.done = taskData.done
                task.dueDate = Calendar.current.date(from: DateComponents(year: taskData.year, month: taskData.month, day: taskData.day))
                task.priority = taskData.priority
                task.name = taskData.name
            }
            
            try managedObjectContext.save()
        }
    }
}
