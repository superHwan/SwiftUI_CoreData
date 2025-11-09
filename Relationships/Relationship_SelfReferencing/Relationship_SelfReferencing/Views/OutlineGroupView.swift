//
//  OutlineGroupView.swift
//  Relationship_SelfReferencing
//
//  Created by Sanny on 2025/11/9.
//

import SwiftUI

struct OutlineGroupView: View {
    // 当前sortDescriptors只对顶层数据有效
    @FetchRequest<WorkerEntity>(
        sortDescriptors: [SortDescriptor(\.name)],
        predicate: NSPredicate(format: "manager == nil")
    )
    private var managers
    
    var body: some View {
        NavigationView {
            List {
                // 将 mangers 的 FetchedResults<WorkerEntity> 转为 [WorkerEntity] 否则 children 的Keypath 会出现类型差异 -> 异常
                OutlineGroup(Array(managers), children: \.viewSubordinates) { worker in
                    Text(worker.viewName)
                }
            }
            .navigationTitle("Outline Group")
        }
    }
}

#Preview {
    OutlineGroupView()
        .environment(\.managedObjectContext, CoreDataStack.previewForWorkerDataModel)
}
