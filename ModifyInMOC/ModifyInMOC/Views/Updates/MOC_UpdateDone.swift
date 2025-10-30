//
//  MOC_UpdateDone.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/29.
//
// 左滑 更新单个属性：done

import SwiftUI

struct MOC_UpdateDone: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)])
    private var tasks
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                Text(task.viewTaskName)
                    .strikethrough(task.done, color: .red) // 删除线
                    .swipeActions {
                        Button {
                            task.done.toggle()
                            try? moc.save()
                        } label: {
                            Image(systemName: task.done ? "arrow.uturn.backward.circle" : "checkmark.circle")
                        }
                        .tint(task.done ? .red : .green)
                    }
            }
        }
        .navigationTitle("Update \'done\'")
    }
}

#Preview {
    MOC_UpdateDone()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
