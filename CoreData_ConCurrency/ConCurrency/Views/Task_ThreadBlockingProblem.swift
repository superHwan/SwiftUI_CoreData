//
//  Task_ThreadBlockProblem.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/12.
//
// 使用sleep 模拟线程阻塞
// 点击按钮后，由于线程阻塞，UI 无法响应

import SwiftUI

struct Task_ThreadBlockingProblem: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: [])
    private var countries
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(countries) { country in
                        Text(country.viewCountry)
                            .foregroundStyle(country.viewCountry == "Australia" ? .red : .primary)
                    }
                }
                
                Button("Change first to Australia") {
                    let country = countries[0]
                    Thread.sleep(forTimeInterval: 2) // 模拟 耗时2s的操作
                    country.country = "Australia"
                    try! moc.save()
                }
            }
            .navigationTitle("Blocking")
        }
    }
}

#Preview {
    Task_ThreadBlockingProblem()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
