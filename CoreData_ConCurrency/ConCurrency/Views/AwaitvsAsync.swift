//
//  AwaitvsAsync.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/13.
//
// 由于 perform 可 使用/不使用 await，下面是比较这两种情况

import SwiftUI

struct AwaitvsAsync: View {
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
                
                // 数字代表输出顺序
                Button("Change fourth to Peru") {
                    let _ = print("---- Await ----")
                    print(1)
                    
                    Task { // Asynchronous
                        print(3)
                        await moc.perform { // 挂起，直到 perform块执行完毕
                            print(4)
                            let country = countries[3]
                            country.country = "Peru"
                            try! moc.save()
                            print(5)
                        }
                        // await 执行完毕，才能执行
                        print(6) // perform 结束后执行
                    }
                    
                    print(2)
                }
                .buttonStyle(.borderedProminent)
                
                // Task 提供异步环境，内部代码为异步操作
                // moc.perform 类似于 异步任务内的异步任务
                Button("Change second to Spanish") {
                    let _ = print("---- Async ----")
                    print(1)
                    
                    Task { // Asynchronous
                        print(3)
                        
                        moc.perform { // 异步操作
                            print(5)
                            let country = countries[1]
                            country.country = "Spanish"
                            try! moc.save()
                            print(6)
                        }
                        
                        print(4) // 不等待perform的结束
                    }
                    
                    print(2)
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Await vs Async")
        }
    }
}

#Preview {
    AwaitvsAsync()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
