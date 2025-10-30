//
//  InsertTaskWithAlertView.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/29.
//
// 下滑直接退出
// 点击Close退出时，弹警告，用户确认后再退出

import SwiftUI

struct InsertTaskWithAlertView: View {
    @Binding var showSheet: Bool // 用于关闭
    @State var showAlert: Bool = false // 用于呈现警告
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    // MARK: 待修改的属性值
    @State private var taskName: String = ""
    @State private var priority: Int16 = 1
    @State private var dueDate: Date = Date()
    @State private var done: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading, spacing: 30) {
                TextField("Task Name", text: $taskName)
                    .padding()
                Divider()
                
                Section("Priority: \(priority)") {
                    Picker(selection: $priority) {
                        Text("1").tag(Int16(1))
                        Text("2").tag(Int16(2))
                        Text("3").tag(Int16(3))
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                }
                Divider()
                
                
                // 只显示到日，不显示时分
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                Divider()
                
                Toggle("Done", isOn: $done)
                
                Button("Save") {
                    let task = TaskEntity(context: moc)
                    // 实例在 memory 和 UI 层面修改
                    task.taskName = taskName
                    task.priority = priority
                    task.dueDate = dueDate
                    task.done = done
                    
                    // 保存修改到持久化存储
                    try? moc.save()
                    
                    dismiss() // 自动返回上一个页面
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity) // 居中
                .disabled(taskName.isEmpty) // 没有填入任务名时，按钮不可用
                
                Spacer()  // 用于占满页面
            }
            .navigationTitle("New Task")
            .background(Color(.secondarySystemBackground))
            .toolbar {
                // 直接关闭，而不保存信息
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.showAlert = true
                    } label: {
                        Text("Close")
                    }
                }
            }
            .alert("Confirm Close: Do not save changes", isPresented: $showAlert) {
                Button("Yes") {
                    self.showSheet = false // 关闭sheet
                }
                Button("Do nothing") {
                    
                }
            }
        }
    }
}

struct InsertTaskWithAlertView_Preview: PreviewProvider {
    static var previews: some View {
        let moc = CoreDataStack.singleEntityForPreview
        let task = TaskEntity(context: moc)
        task.taskName = "阅读 20min"
        task.dueDate = Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 22))
        task.priority = 3
        task.done = false
        try? moc.save()
        
        
        return InsertTaskWithAlertView(showSheet: .constant(false))
            .environment(\.managedObjectContext, moc)
    }
}
