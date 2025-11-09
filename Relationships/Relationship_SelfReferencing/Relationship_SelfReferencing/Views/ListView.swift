//
//  ListView.swift
//  Relationship_SelfReferencing
//
//  Created by Sanny on 2025/11/9.
//

import SwiftUI

struct ListView: View {
    // 当前sortDescriptors只对顶层数据有效
    @FetchRequest<WorkerEntity>(
        sortDescriptors: [SortDescriptor(\.name)],
        predicate: NSPredicate(format: "manager == nil")
    )
    private var managers
    
    var body: some View {
        NavigationView {
            List(Array(managers), children: \.viewSortedSubordinates) { worker in
                Text(worker.viewName)
            }
            .navigationTitle("List")
        }
    }
}

#Preview {
    ListView()
        .environment(\.managedObjectContext, CoreDataStack.previewForWorkerDataModel)
}
