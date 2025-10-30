//
//  MOC_UpdateTask.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/29.
//

import SwiftUI

struct MOC_UpdateTask: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<TaskEntity>(sortDescriptors: [SortDescriptor(\.done)])
    private var tasks
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks) { task in
                    NavigationLink {
                        EditTaskView(task: task)
                    } label: {
                        TaskView(task: task)
                    }

                }
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    MOC_UpdateTask()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
