//
//  ConnectingEntitiesWithCondition.swift
//  FetchProperty
//
//  Created by Sanny on 2025/11/18.
//
// $FETCHED_PROPERTY 的使用
// 获取选定汽车商 价格低于 50万的汽车：
// autosInIdealPrice: `manufacturerUUID == $FETCH_SOURCE.uuid AND price < $FETCHED_PROPERTY.userInfo.idealPrice`

import SwiftUI

struct ConnectingEntitiesWithCondition: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var manufacturers
    
    var body: some View {
        NavigationStack {
            List(manufacturers) { manufacturer in
                NavigationLink {
                    List(manufacturer.viewAutosInIdealPrice) { auto in
                        Text("\(auto.viewModel): \(auto.price)")
                    }
                    .navigationTitle("\(manufacturer.viewName) below 500k")
                } label: {
                    Text(manufacturer.viewName)
                }
            }
            .navigationTitle("$FETCHED_PROPERTY")
        }
    }
}

#Preview {
    ConnectingEntitiesWithCondition()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
