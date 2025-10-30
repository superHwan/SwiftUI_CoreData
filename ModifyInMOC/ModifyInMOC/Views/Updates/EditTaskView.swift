//
//  EditTaskView.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/29.
//
// 记录编辑值，Button保存

import SwiftUI

struct EditTaskView: View {
    let task: TaskEntity? // 待修改的实例
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    // MARK: 待修改的属性值
    @State private var taskName: String = ""
    @State private var priority: Int16 = 0
    @State private var dueDate: Date = Date()
    @State private var done: Bool = false
    
    
    var body: some View {
        
        VStack {
            Form {
                Section("Name") {
                    TextField("Task Name", text: $taskName)
                }
                
                Section("Priority") {
                    Picker(selection: $priority) {
                        Text("1").tag(Int16(1))
                        Text("2").tag(Int16(2))
                        Text("3").tag(Int16(3))
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Due Date") {
                    // 只显示到日，不显示时分
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                }
                
                Section("Done") {
                    Toggle("Done", isOn: $done)
                }
                
            }
            
            Button("Save") {
                // 实例在 memory 和 UI 层面修改
                task?.taskName = taskName
                task?.priority = priority
                task?.dueDate = dueDate
                task?.done = done
                
                // 保存修改到持久化存储
                try? moc.save()
                
                dismiss() // 自动返回上一个页面
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            // 从传入实例中获取所需的属性值
            taskName = task?.taskName ?? ""
            priority = task?.priority ?? 0
            dueDate = task?.dueDate ?? Date()
            done = task?.done ?? false
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Edit Task")
    }
}

struct EditTaskView_Preview: PreviewProvider {
    static var previews: some View {
        let moc = CoreDataStack.singleEntityForPreview
        let task = TaskEntity(context: moc)
        task.taskName = "阅读 20min"
        task.dueDate = Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 22))
        task.priority = 3
        task.done = false
        try? moc.save()
        
        
        return EditTaskView(task: task)
            .environment(\.managedObjectContext, moc)
    }
}
