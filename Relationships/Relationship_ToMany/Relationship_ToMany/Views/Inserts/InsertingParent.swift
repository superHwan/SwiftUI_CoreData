//
//  InsertingParent.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// 以 Section 的形式呈现，标题 Inserting a Parent
// 通过 toolbar 在右上角增加一个 “新增”功能的按钮，该按钮弹出 sheet 来呈现新增页

import SwiftUI

struct InsertingParent: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [])
    private var manufacturers
    @State private var newManufacture = false
    
    var body: some View {
        NavigationView {
            List(manufacturers) { manufacturer in
                Section {
                    ForEach(manufacturer.viewAutoEntities) { auto in
                        Text(auto.viewModel)
                    }
                } header: {
                    Text(manufacturer.viewName)
                }
            }
            .navigationTitle("Inserting a Parent")
            .toolbar {
                Button {
                    newManufacture.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $newManufacture) {
                NewManufacturerView()
                    .presentationDetents([.medium]) // 半屏
            }
        }
    }
}

#Preview {
    InsertingParent()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
