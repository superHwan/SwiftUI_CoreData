//
//  TaskView.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/29.
//
// 显示单个Task

import SwiftUI

struct TaskView: View {
//    let task: TaskEntity // 不会自动更新UI，重新进入界面才为最新值
    @ObservedObject var task: TaskEntity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.viewTaskName)
                    .font(.title2)
                    .strikethrough(task.done, color: .red)
                Text(task.viewDueDate)
                    .font(.caption)
            }
            
            Spacer()
            
            Image(systemName: task.viewPriority)
                .foregroundStyle(task.viewPriorityColor)
                .font(.title2)
        }
    }
}

struct TaskView_Preview: PreviewProvider {
    static var previews: some View {
        let moc = CoreDataStack.singleEntityForPreview
        let task = TaskEntity(context: moc)
        task.taskName = "阅读 20min"
        task.dueDate = Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 22))
        task.priority = 3
        task.done = false
        try? moc.save()
        
        
        return TaskView(task: task)
            .environment(\.managedObjectContext, moc)
    }
}
