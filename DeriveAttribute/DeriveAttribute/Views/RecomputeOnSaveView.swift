//
//  RecomputeOnSaveView.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/11.
//
// Derived Attribute 的更新时机：context.save() 或 网络同步
// 拆分 save() 与 添加操作，点击最右侧的保存按钮才能更新 Derived 相关的属性值

import SwiftUI

struct RecomputeOnSaveView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<NationEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var nations
    
    @State private var selectedNation: NationEntity?
    
    var body: some View {
        NavigationStack {
            List(nations) { nation in
                Section {
                    VStack(alignment: .leading) {
                        Text(nation.viewBeachNames, format: .list(type: .and, width: .standard))
                        Text("Total beach count: \(nation.beachCount)")
                            .foregroundStyle(.red)
                        Text(nation.viewLastUpdated)
                            .foregroundStyle(.green)
                    }
                } header: {
                    HStack {
                        Text(nation.viewName)
                        Spacer()
                        Button {
                            selectedNation = nation
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .navigationTitle("Recompute on save")
            .sheet(item: $selectedNation) { nation in // 呈现新增页
                NewBeachView(nation: nation)
                    .presentationDetents([.medium])
            }
            .toolbar {
                Button { // 保存和更新按钮
                    do {
                        try moc.save()
                        // 强制context丢弃当前状态，并从持久化存储协调器中重新获取最新数据
                        moc.refreshAllObjects()
                    } catch {
                        print("Failed to save new data: \(error.localizedDescription)")
                    }
                } label: {
                    Image(systemName: "square.and.arrow.down")
                }

            }
        }
    }
}

#Preview {
    RecomputeOnSaveView()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
