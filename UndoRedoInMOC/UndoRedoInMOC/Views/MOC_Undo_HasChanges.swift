//
//  MOC_Undo_HasChanges.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
// 使用 context 的 hasChanges 属性，当有对象发生更改时，撤回/保存按钮才可用，否则禁用。
// 只提供一个操作：删除

import SwiftUI

struct MOC_Undo_HasChanges: View {
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
            .navigationTitle("Undo(hasChanges)")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button { // 撤回按钮
                        moc.undo()
                        saved = (!moc.hasChanges) // 退回到初始状态，saved恢复true
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }
                    .disabled(saved) // true-禁用

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
    MOC_Undo_HasChanges()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
