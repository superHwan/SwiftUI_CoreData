//
//  MOCCount.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/23.
//
// 使用 NSManagedObjectContext
// 1. 在不需要获得数据，仅需获得总数时；资源消耗较 @FetchRequest 少
// 2. 筛选出位于 United States 的公园，且仅显示其name

import SwiftUI

struct MOCDetails: View {
    @Environment(\.managedObjectContext) var moc
    @State private var total = 0
    @State private var parksInUnitedStates: [String] = []
    @State private var partialCount = 0
    
    var body: some View {
        NavigationStack {
            List {
                VStack {
                    Text("Parks")
                        .badge(total)
                        .font(.title2)
                }
                
                VStack(alignment: .leading) {
                    Text("Parks in United States")
                        .badge(partialCount)
                        .font(.title2)
                        .bold()
                    Text(parksInUnitedStates, format: .list(type: .and, width: .standard))
                }
            }
            .task { // 获得总条目数
                if let count = try? moc.count(for: ParkEntity.fetchRequest()) {
                    total = count
                }
            }
            .task { // 筛选出位于 United States 的公园，且仅显示其name
                let request = ParkEntity.fetchRequest()
                request.predicate = NSPredicate(format: "country == %@", "United States")
                request.sortDescriptors = [NSSortDescriptor(keyPath: \ParkEntity.name, ascending: true)]
                
                do {
                    let parks = try moc.fetch(request) // [ParkEntity]
                    partialCount = parks.count
                    // 获取 [ParkEntity] 内单个数据的 viewName属性值
                    for park in parks {
                        parksInUnitedStates.append(park.viewName)
                    }
                } catch {
                    print("Fetch failed: ", error.localizedDescription)
                }
                
            }
            .navigationTitle("详情页")
        }
    }
}
