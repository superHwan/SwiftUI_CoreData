//
//  NestedDisplay.swift
//  Relationships
//
//  Created by Sanny on 2025/11/5.
//
// Section 嵌套呈现（类似下拉视窗）

import SwiftUI

struct NestedDisplay: View {
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
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
            .navigationTitle("Nested")
        }
    }
}

#Preview {
    NestedDisplay()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
