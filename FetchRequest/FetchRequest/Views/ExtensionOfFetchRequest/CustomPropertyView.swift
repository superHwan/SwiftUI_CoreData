//
//  CustomPropertyView.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/23.
//
// 配置NSFetchRequest  方式一：创建属性
// count 属性显示筛选后的条目数

import SwiftUI
import CoreData

struct CustomPropertyView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(fetchRequest: ParkEntity.firstFive) private var parks
    
    var body: some View {
        NavigationView {
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
            .safeAreaInset(edge: .bottom) {
                Text("Total Parks: \(parks.count)")
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(.bar)
            }
        }
        .task {
            do {
                try await ParkDataImporter.importParks(to: viewContext)
            } catch {
                print("Failed to load data:", error.localizedDescription)
            }
        }
    }
}

extension ParkEntity {
    static let noFaultRequest: NSFetchRequest = {
        // 返回该实体的fetch请求的函数
        let request = NSFetchRequest<ParkEntity>(entityName: "ParkEntity")
        
        request.predicate = nil
        request.sortDescriptors = [.init(keyPath: \ParkEntity.name, ascending: true)]
        request.returnsObjectsAsFaults = false
        
        return request
    }()
    
    static var firstFive: NSFetchRequest<ParkEntity> {
        let request = ParkEntity.fetchRequest() // 返回该实体的fetch请求的函数
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ParkEntity.rating, ascending: true)]
        
        request.fetchLimit = 5 // 设置仅获取 5 个，不能外部使用 @FetchRequest设置
        
        return request
    }
}

#Preview {
    CustomPropertyView()
}
