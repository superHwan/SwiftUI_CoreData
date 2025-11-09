//
//  ParentChild.swift
//  Relationships
//
//  Created by Sanny on 2025/11/5.
//
// 效果：NavigationLink 跳转到To-One 关系
import SwiftUI

struct ParentChild: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var manufacturers
    
    var body: some View {
        NavigationStack {
            // parent-汽车制造商
            List(manufacturers) { manufacturer in
                NavigationLink {
                    // child-auto
                    // autoEntities->NSSet, viewAutoEntities->array
                    List(manufacturer.viewAutoEntities) { auto in
                        Text(auto.viewModel)
                    }
                } label: {
                    Text(manufacturer.viewName)
                }
            }
            .navigationTitle("Parent-Child")
        }
    }
}

#Preview {
    ParentChild()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
