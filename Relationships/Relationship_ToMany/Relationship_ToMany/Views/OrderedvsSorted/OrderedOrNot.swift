//
//  NotOrdered.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
/* 预备处理
 1. 自行在 To-Many 勾/不勾选 Ordered 观察视图变化
 2. extension ManufacturerEntity：勾选-使用array，无勾选-使用allObjects
 */
/* 数据导入顺序
 Audi：Q4 e-tron，e-tron GT，RS e-tron GT
 Toyota：Camry，RAV4，Prius
 Ford：F-150，Mustang Mach-E，Explorer
 BMW：i4，X5，3 Series
 Tesla：Model 3，Model Y，Cybertruck
 Hyundai：Ioniq 5，Tucson，Santa Fe
 */

import SwiftUI

struct OrderedOrNot: View {
    // 父实体无Sorted
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [])
    private var manufacturers
    
    
    var body: some View {
        NavigationStack {
            List(manufacturers) { manufacturer in
                Section(manufacturer.viewName) {
                    ForEach(manufacturer.viewAutoEntities) { auto in
                        Text(auto.viewModel)
                    }
                }
            }
            .navigationTitle("OrderedOrNot")
        }
    }
}

#Preview {
    OrderedOrNot()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
