//
//  ConnectingTwoEntities.swift
//  FetchProperty
//
//  Created by Sanny on 2025/11/18.
//

// 获取汽车制造商 所有的汽车系列：
// autos: manufacturerUUID == $FETCH_SOURCE.uuid
// 错误用法：manufacturer == $FETCH_SOURCE.name，匹配业务属性，没有确保标识符的唯一性约束，Core Data 无法验证其唯一性和稳定性

import SwiftUI

struct ConnectingTwoEntities: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var manufacturers
    
    var body: some View {
        NavigationStack {
            List(manufacturers) { manufacturer in
                NavigationLink {
                    List(manufacturer.viewAutos) { auto in
                        Text(auto.viewModel)
                    }
                    .navigationTitle("\(manufacturer.viewName)")
                    
                    // 错误用法 ❌
//                    List(manufacturer.viewNewAutos) { auto in
//                        Text(auto.viewModel)
//                    }
//                    .navigationTitle("\(manufacturer.viewAutos_Wrong)")
                } label: {
                    Text(manufacturer.viewName)
                }

            }
            .navigationTitle("The autos included")
        }
    }
}

#Preview {
    ConnectingTwoEntities()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
