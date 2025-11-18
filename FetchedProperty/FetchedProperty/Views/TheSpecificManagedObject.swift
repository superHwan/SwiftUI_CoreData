//
//  TheSpecificManagedObject.swift
//  FetchProperty
//
//  Created by Sanny on 2025/11/18.
//
// $FETCH_SOURCE 的使用
// manufacturersInSameCountry: country == $FETCH_SOURCE.country
// 与当前汽车商 相同国家的其他汽车商

import SwiftUI

struct TheSpecificManagedObject: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: []) private var manufacturers
    
    var body: some View {
        NavigationStack {
            List(manufacturers) { manufacturer in
                NavigationLink {
                    List(manufacturer.viewManufacturersInSameCountry) { mfrInSameCountry in
                        Text(mfrInSameCountry.viewName)
                    }
                    .navigationTitle("\(manufacturer.viewCountry)")
                } label: {
                    Text(manufacturer.viewName)
                }
            }
            .navigationTitle("Fetch the same country")
        }
    }
}

#Preview {
    TheSpecificManagedObject()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
