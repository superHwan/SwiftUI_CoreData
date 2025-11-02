//
//  MOC_Redo.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
// 重做

import SwiftUI

struct MOC_Redo: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)])
    private var tasks
    
    @State private var saved = true
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    Text(task.viewName)
                        .strikethrough(task.done, color: .red)
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("Redo")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Button { // 撤回按钮
                        moc.undo()
                        saved = (!moc.hasChanges) // 退回到初始状态，saved恢复true
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }
                    .disabled(saved) // true-禁用
                    
                    Button { // 重做按钮（有操作未保存，说明可能存在前一步操作）
                        moc.redo()
                        saved = (!moc.hasChanges)
                    } label: {
                        Image(systemName: "arrow.uturn.right")
                    }
                    .disabled(saved == false) // true-禁用

                    Button { // 保存按钮
                        try? moc.save()
                        saved = (!moc.hasChanges)
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(saved) // true-禁用
                }
            }
        }
    }
    
    // 映射删除
    private func deleteTask(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(tasks[offset]) // 内存层面（memory）
        }
        // 更改当前修改状态
        saved = false // 为了方便，此处保证必更改
//        saved = (!moc.hasChanges)
    }
}

#Preview {
    MOC_Redo()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
