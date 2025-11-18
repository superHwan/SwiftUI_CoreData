//
//  WithPredicate.swift
//  FetchProperty
//
//  Created by Sanny on 2025/11/18.
//
// manufacturersWithoutBMW 需要实例调用
// 使用不含 BMW 来调用
import SwiftUI

struct WithPredicate: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [],
                                      predicate: NSPredicate(format: "name == 'BMW'"))
    private var justBMW
    
    var body: some View {
        VStack {
            List(justBMW) { bmw in
                VStack(alignment: .leading) {
                    Text(bmw.viewName).font(.title3)
                    Text(bmw.viewCountry)
                        .foregroundStyle(.gray)
                }
                
                Section("All other manufacturers") {
                    ForEach(bmw.viewManufacturersWithoutBMW) { manufacturer in
                        VStack(alignment: .leading) {
                            Text(manufacturer.viewName).font(.title3)
                            Text(manufacturer.viewCountry)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding()
                .headerProminence(.increased) // 加粗加大header
            }
        }
    }
}

#Preview {
    WithPredicate()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
