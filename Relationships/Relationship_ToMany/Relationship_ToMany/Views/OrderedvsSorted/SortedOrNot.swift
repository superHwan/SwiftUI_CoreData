//
//  SortedOrNot.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// 下面例子的情况：不勾选 Ordered
/* 数据导入顺序
 Audi：Q4 e-tron，e-tron GT，RS e-tron GT
 Toyota：Camry，RAV4，Prius
 Ford：F-150，Mustang Mach-E，Explorer
 BMW：i4，X5，3 Series
 Tesla：Model 3，Model Y，Cybertruck
 Hyundai：Ioniq 5，Tucson，Santa Fe
 */

import SwiftUI

struct SortedOrNot: View {
    
    // 父实体Sorted by name
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var manufacturers
    
    // Value of type 'NSSet?' has no member 'name’
//    @FetchRequest<ManufacturerEntity>(sortDescriptors: [
//        SortDescriptor(\.name),
//        SortDescriptor(\ManufacturerEntity.autoEntities.name)
//    ])
//    private var manus
    
    
    var body: some View {
        NavigationStack {
            List(manufacturers) { manufacturer in
                Section(manufacturer.viewName) {
                    // 排序“子”实体
                    ForEach(manufacturer.viewSortedAutos) { auto in
                        Text(auto.viewModel)
                    }
                }
            }
            .navigationTitle("SortedOrNot")
        }
    }
}

#Preview {
    SortedOrNot()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
