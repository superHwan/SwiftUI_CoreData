//
//  NullifyRule.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// 预备工作：AutoEntity 处 manufacturereEntity 关系删除规则为 Nullify，且勾选 Ordered
// 效果：删除父实体-子实体指向nil，UI中变红；删除子实体-父实体指向nil，从UI中消失

import SwiftUI

struct NullifyRule: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var manufacturers
    
    // 根据父实体的name 排序
    @FetchRequest<AutoEntity>(sortDescriptors: [SortDescriptor(\.manufacturerEntity?.name)])
    private var autos
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(manufacturers) { manufacturer in
                        Text(manufacturer.viewName)
                    }
                    .onDelete(perform: deleteManufacturer) // 删除父实体
                }
                
                List {
                    ForEach(autos) { auto in
                        Text("\(auto.viewManufacturer): \(auto.viewModel)")
                            .foregroundStyle(auto.viewManufacturer == "N/A" ? .red : .primary)
                    }
                    .onDelete(perform: deleteAuto) // 删除子实体
                }
            }
            .navigationTitle("Nullify")
        }
    }
    
    private func deleteManufacturer(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(manufacturers[offset])
        }
        try? moc.save()
    }
    
    private func deleteAuto(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(autos[offset])
        }
        try? moc.save()
    }
}

#Preview {
    NullifyRule()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
