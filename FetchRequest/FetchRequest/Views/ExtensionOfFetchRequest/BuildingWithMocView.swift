//
//  BuildingWithMocView.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/23.
//
// 使用 NSManagedObjectContext 创建并调用一个 fetch request，赋值给 @State 属性值
// 名字逆序
// 此处的使用为引入，一般用于获得实体单个属性值 / 使用某些特性

import SwiftUI
import CoreData

struct BuildingWithMocView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var parks: [ParkEntity] = []
    
    var body: some View {
        NavigationStack {
            List(parks) { park in
                HStack {
                    Image(uiImage: park.viewImage)
                        .resizable()
                        .frame(width: 80, height: 60)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                            Text(park.viewName)
                                .font(.title)
                        Text(park.viewLocation)
                            .fontWeight(.light)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("Parks")
        }
        .task {
            do {
                try await ParkDataImporter.importParks(to: viewContext)
            } catch {
                print("Failed to load data:", error.localizedDescription)
            }
        }
        .task {
//            let request = NSFetchRequest<ParkEntity>(entityName: "ParkEntity")
            let request = ParkEntity.fetchRequest() // 与上面效果一致，二选一即可
            
            // 具体设置
            request.sortDescriptors = [.init(keyPath: \ParkEntity.name, ascending: false)]
            
//            request.resultType = .managedObjectResultType // 设置为对象结果类型，返回托管对象
            
            do {
                let parksData = try viewContext.fetch(request) // 返回值类型[ParkEntity]
                parks = parksData
            } catch {
                print("Fetch failed:", error.localizedDescription)
            }
        }
    }
}
