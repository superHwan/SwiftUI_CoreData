//
//  PassEntitiesAround_Correct.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/15.
//
// 通过 objectID 实现跨线程/上下文 传递对象

import SwiftUI

struct PassEntitiesAround_Correct: View {
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
                
                // 与主上下文相互独立，UI 显示 "N/A"
                let backgroundContext = CoreDataStack.shared.persistentContainer.newBackgroundContext()
                
                backgroundContext.perform {
                    let country = CountryEntity(context: backgroundContext) // breakpoint
                    country.country = "Portugal"
//                    let id = country.objectID
                    try! backgroundContext.save()
                    
                    let id = country.objectID
                    
                    DispatchQueue.main.async {
                        // 这里确保id存在；不确定可使用 existingObject(with:)
                        let newCountry = moc.object(with: id) as! CountryEntity
                        newCountryName = "Added: \(newCountry.viewCountry)"
                    }
                }
            }
        }
    }
}

#Preview {
    PassEntitiesAround_Correct()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
