//
//  MOC_Delete.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/29.
//
// 左滑删除

import SwiftUI

struct MOC_Delete: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)]) private var tasks
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                Text(task.viewTaskName)
                    .strikethrough(task.done, color: .red)
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle("Delete")
    }
    
    // 映射删除
    private func deleteTask(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(tasks[offset]) // 内存层面（memory）
        }
        // 如有需要，可做成单独的按钮
        try? moc.save() // 持久化存储层面（the persistent storage）
    }
}

#Preview {
    MOC_Delete()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
