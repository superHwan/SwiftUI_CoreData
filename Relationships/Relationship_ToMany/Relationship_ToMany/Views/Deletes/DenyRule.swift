//
//  DenyRule.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// 预备：ManufacturerEntity 的 autoEntities 关系的删除规则设为 Deny

import SwiftUI

struct DenyRule: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<ManufacturerEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var manufacturers
    @FetchRequest<AutoEntity>(sortDescriptors: [SortDescriptor(\.manufacturerEntity?.name)])
    private var autos
    
    @State private var deletedName = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    ForEach(manufacturers) { manufacturer in
                        Text(manufacturer.viewName)
                    }
                    .onDelete(perform: deleteManufacturer)
                }
                .frame(maxHeight: CGFloat(50 * manufacturers.count))
                
                List {
                    ForEach(autos) { auto in
                        Text("\(auto.viewManufacturer): \(auto.viewModel)")
                    }
                    .onDelete(perform: deleteAuto)
                }
            }
            .navigationTitle("Deny")
        }
    }
    
    private func deleteManufacturer(offsets: IndexSet) {
        for offset in offsets {
            deletedName = manufacturers[offset].viewName
            moc.delete(manufacturers[offset])
        }
        // 此时已从 memory 中删除，且 UI 也刷新
        do {
            try moc.save()
        } catch {
            print("Failed to delete the ManufacturerEntity - \(deletedName): \(error.localizedDescription)")
            moc.undo() // 恢复
        }
    }
    
    private func deleteAuto(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(autos[offset])
        }
        try? moc.save()
    }
}

#Preview {
    DenyRule()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory )
}
