//
//  MOC_Undo_LevelsOfUndo.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
// 使用 levelsOfUndo 限制跟踪更改数量

import SwiftUI

struct MOC_Undo_LevelsOfUndo: View {
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
            .navigationTitle("Undo Scope")
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
    MOC_Undo_LevelsOfUndo()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
