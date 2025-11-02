//
//  MOC_Rollback.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
// rollback：撤销所有更改

import SwiftUI

struct MOC_Rollback: View {
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
            .navigationTitle("Rollback")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button { // 撤回全部操作按钮
                        moc.rollback()
                    } label: {
                        Image(systemName: "arrow.trianglehead.counterclockwise.rotate.90")
                    }

                    Button { // 保存按钮
                        try? moc.save()
                    } label: {
                        Image(systemName: "checkmark")
                    }

                }
            }
            .onAppear {
                moc.undoManager?.levelsOfUndo = 2 // 只跟踪最新的两次更改
            }
        }
    }
    
    // 映射删除
    private func deleteTask(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(tasks[offset]) // 内存层面（memory）
        }
    }
}

#Preview {
    MOC_Rollback()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}

