//
//  SectionedFetchRequestView.swift
//  Relationships
//
//  Created by Sanny on 2025/11/5.
//
// 以 @SectionedFetchRequest 获得的托管对象的id 作为 Section 的title
// 获取 To-One 关系中的托管对象，其中分组标识符为 其关系对象的某属性

import SwiftUI

struct SectionedFetchRequestView: View {
    @SectionedFetchRequest<String?, AutoEntity>(sectionIdentifier: \.manufacturerEntity?.name,
                                                sortDescriptors: [SortDescriptor(\.manufacturerEntity?.name)])
    private var autos
    
    var body: some View {
        NavigationStack {
            List(autos) { section in
                Section {
                    ForEach(section) { auto in
                        Text(auto.viewModel)
                    }
                } header: {
                    Text(section.id ?? "N/A")
                }
            }
            .navigationTitle("SFR")
        }
    }
}

#Preview {
    SectionedFetchRequestView()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
