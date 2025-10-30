//
//  MOC_Insert.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/29.
//
// 使用 sheet 展示添加页面
// InsertTaskView：向下滑退出，且不保存
// InsertTaskWithAlertView：向下滑/按钮退出，且不保存
// 难且不推荐：下滑退出且弹出警告

import SwiftUI

struct MOC_Insert: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)])
    private var tasks
    
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                TaskView(task: task)
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
//            InsertTaskView() // 下滑 退出
            InsertTaskWithAlertView(showSheet: $showSheet) // 下滑/按钮 退出
        }
    }
}

#Preview {
    NavigationView {
        MOC_Insert()
            .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
    }
}
