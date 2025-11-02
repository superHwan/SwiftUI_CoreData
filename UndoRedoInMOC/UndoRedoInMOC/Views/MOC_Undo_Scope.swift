//
//  MOC_Undo_Scope.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
// 不需要在整个应用程序中执行撤消操作，仅需在某些视图使用，可将撤消的范围限制在目标视图

import SwiftUI

struct MOC_Undo_Scope: View {
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
                moc.undoManager = UndoManager()
            }
            .onDisappear {
                moc.undoManager = nil
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
    MOC_Undo_Scope()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
