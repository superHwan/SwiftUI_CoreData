//
//  CascadeRule.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// 预备：将 ManufacturerEntity 的 autoEntities 关系的删除规则设为 Cascade

import SwiftUI

struct CascadeRule: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var manufacturers
    @FetchRequest<AutoEntity>(sortDescriptors: [SortDescriptor(\.manufacturerEntity?.name)])
    private var autos
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(manufacturers) { manufacturer in
                        Text(manufacturer.viewName)
                    }
                    .onDelete(perform: deleteManufacturer)
                }
                .frame(maxHeight: CGFloat(50 * manufacturers.count)) // 实现删除后向上缩进
                
                List(autos) { auto in
                    Text("\(auto.viewManufacturer): \(auto.viewModel)")
                }
            }
            .navigationTitle("Cascade")
        }
    }
    
    private func deleteManufacturer(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(manufacturers[offset])
        }
        try! moc.save()
    }
}

#Preview {
    CascadeRule()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
