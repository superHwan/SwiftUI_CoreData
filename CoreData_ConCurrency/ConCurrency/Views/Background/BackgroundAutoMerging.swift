//
//  BackgroundAutoMerging.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/14.
//
/*
 persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
 用途：上下文会自动合并对持久存储所做的更改
 可在 CoreDataStack.swift 初始化容器部分注销该句代码，比较 BackgroundAutoMerging 与 NewBackgroundContext
 */

import SwiftUI

struct BackgroundAutoMerging: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    
    var body: some View {
        List {
            ForEach(countries) { country in
                Text(country.viewCountry)
                    .foregroundStyle(country.viewCountry == "Australia" ? .red : .primary)
            }
        }
        .refreshable {
            // 上下文会自动合并对持久存储所做的更改
            moc.automaticallyMergesChangesFromParent = true // 关键设置
            
            // 由持久化容器提供的 后台队列上的托管对象上下文
            let backgroundContext = CoreDataStack.shared
                .persistentContainer.newBackgroundContext()
            
            // 拉取刷新时，往后台队列添加一个新的国家
            backgroundContext.perform {
                let country = CountryEntity(context: backgroundContext)
                country.country = "Australia"
                
                try! backgroundContext.save()
            }
            
            // 后台上下文也可使用 await
            Task {
                await backgroundContext.perform {
                    let country = CountryEntity(context: backgroundContext)
                    country.country = "New Zealand"
                    
                    try! backgroundContext.save()
                }
                
                // Execute code here only AFTER the perform is done.
            }
        }
    }
}
