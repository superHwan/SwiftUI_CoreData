//
//  PassEntitiesAround_Wrong.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/14.
//
// 错误操作：跨线程/上下文 传递对象引用

import SwiftUI

struct PassEntitiesAround_Wrong: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    @State private var newCountryName = "Status: Loading"
    
    var body: some View {
        VStack {
            Text(newCountryName)
            
            List {
                ForEach(countries) { country in
                    Text(country.viewCountry)
                        .foregroundStyle(country.viewCountry == "Portugal" ? .red : .primary)
                }
            }
            .refreshable {
                moc.automaticallyMergesChangesFromParent = true
                
                // 与主上下文为父子关系，UI 显示 "Portugal"（具有偶然性）
//                let backgroundContext = CoreDataStack.shared.backgroundContext
                
                // 与主上下文相互独立，UI 显示 "N/A"
                let backgroundContext = CoreDataStack.shared.persistentContainer.newBackgroundContext()
                
                backgroundContext.perform {
                    let country = CountryEntity(context: backgroundContext) // breakpoint
                    country.country = "Portugal"
                    
                    try! backgroundContext.save()
                    
                    DispatchQueue.main.async {
                        // 中断程序
                        newCountryName = "Added: \(country.viewCountry)" // breakpoint
                    }
                }
            }
        }
    }
}

#Preview {
    PassEntitiesAround_Wrong()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
