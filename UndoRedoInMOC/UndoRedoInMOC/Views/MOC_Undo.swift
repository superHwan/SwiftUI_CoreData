//
//  MOC_Undo.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
// 撤回多步
// 调用save()，仍能撤销

import SwiftUI

struct MOC_Undo: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)])
    private var tasks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    Text(task.viewName)
                        .strikethrough(task.done, color: .red)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Undo(Delete)")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button { // 撤回按钮
                        moc.undo()
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }

                    Button { // 保存按钮
                        try? moc.save()
                    } label: {
                        Image(systemName: "checkmark")
                    }

                }
            }
        }
    }
    
    // 映射删除
    private func deleteTask(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(tasks[offset]) // 内存层面（memory）
        }
        // 此处不做自行保存，保存键放到外部
    }
}

#Preview {
    MOC_Undo()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
