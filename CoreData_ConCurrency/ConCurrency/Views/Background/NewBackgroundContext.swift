//
//  NewBackgroundContext.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/14.
//
// 问题：在后台线程的后台上下文进行数据操作后，主上下文没有接受到更改
// 引入：automaticallyMergesChangesFromParent属性，上下文会自动合并对持久存储所做的更改

import SwiftUI

struct NewBackgroundContext: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries // breakpoint 1
    
    var body: some View {
        NavigationView {
            List {
                ForEach(countries) { country in
                    Text(country.viewCountry)
                        .foregroundStyle(country.viewCountry == "Australia" ? .red : .primary)
                }
            }
            .refreshable {
                // 由持久化容器提供的 后台队列上的托管对象上下文
                let backgroundContext = CoreDataStack.shared
                    .persistentContainer.newBackgroundContext()
                
                // 拉取刷新时，往后台队列添加一个新的国家
                backgroundContext.perform {
                    let country = CountryEntity(context: backgroundContext) // breakpoint 2
                    country.country = "Australia"
                    
                    try! backgroundContext.save()
                }
            }
            .navigationTitle("Pull to refresh")
        }
    }
}

#Preview {
    NewBackgroundContext()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
