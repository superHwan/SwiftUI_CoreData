//
//  MOC_TaskOps.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/29.
//
// 汇总前面的操作
// 1. InserTaskView 处新增 isNew: Bool 根据 是否有传入值，判断是编辑已有实例，还是新增实例
// 2. 直接使用已有页面（此处使用该方法）

/*
 问题
 1. 如何实现数据隔离，
 2. 如何给视图导入不同上下文，不使用环境中的上下文，因为下面开启privateMOC会报错
 */

import SwiftUI
import CoreData

struct MOC_TaskOps: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)])
    private var tasks
    
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                NavigationLink {
                    EditTaskView(task: task)
                } label: {
                    TaskView(task: task)
                        .swipeActions {
                            Button {
                                task.done.toggle()
                                try? moc.save()
                            } label: {
                                Image(systemName: task.done ? "arrow.uturn.backward.circle" : "checkmark.circle")
                            }
                            .tint(task.done ? .blue : .green)
                            
                            Button(role: .destructive) {
                                deleteTask(task)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showSheet) {
            InsertTaskWithAlertView(showSheet: $showSheet) // 下滑/按钮 退出
        }
    }
    
    // 不做映射，直接删除
    private func deleteTask(_ task: TaskEntity) {
        moc.delete(task)
        // 如有需要，可做成单独的按钮
        try? moc.save() // 持久化存储层面（the persistent storage）
    }
}

#Preview {
    MOC_TaskOps()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
