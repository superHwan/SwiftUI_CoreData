//
//  Task_NoThreadBlocking.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/13.
//
// 使用 Task：点击按钮后，UI 能响应
// Task 内容被系统分割成小部分，并与主线程上的其他任务一起运行

import SwiftUI

struct Task_NoThreadBlocking: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: [])
    private var countries
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(countries) { country in
                        Text(country.viewCountry)
                            .foregroundStyle(country.viewCountry == "Finland" ? .brown : .primary)
                    }
                }
                
                Button("Change first to Finland") {
                    Task {
                        let country = countries[0]
                        try? await Task.sleep(nanoseconds: 2_000_000_000) // 模拟 耗时2s的操作
                        country.country = "Finland"
                        try! moc.save()
                    }
                }
            }
            .navigationTitle("No Thread Blocking")
        }
    }
}

#Preview {
    Task_NoThreadBlocking()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
