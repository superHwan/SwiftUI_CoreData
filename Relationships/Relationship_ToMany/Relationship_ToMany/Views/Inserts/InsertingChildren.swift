//
//  InsertingChildren.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// 以 Section 的形式呈现，标题 Inserting Children
// 通过 toolbar 在每个 Section 右上角增加一个 “新增”功能的按钮，该按钮弹出 sheet 来呈现新增页;需传递其所属的 父实体

import SwiftUI

struct InsertingChildren: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [])
    private var manufacturers
    
    @State private var selectedManufacturer: ManufacturerEntity?
    
    var body: some View {
        NavigationView {
            List(manufacturers) { manufacturer in
                Section {
                    ForEach(manufacturer.viewAutoEntities) { auto in
                        Text("\(auto.viewYear) \(auto.viewModel)")
                    }
                } header: {
                    HStack {
                        Text(manufacturer.viewName)
                        Spacer()
                        Button {
                            selectedManufacturer = manufacturer
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }

            }
            .navigationTitle("Inserting Children")
            // 通过指定值以呈现sheet
            .sheet(item: $selectedManufacturer) { manufacturer in
                NewAutoView(manufacturer: manufacturer)
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    InsertingChildren()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
