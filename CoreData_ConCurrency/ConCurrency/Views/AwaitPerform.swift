//
//  AwaitPerform.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/13.
//
// 使用 await 挂起 perform 操作

import SwiftUI

struct AwaitPerform: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: [])
    private var countries
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(countries) { country in
                        Text(country.viewCountry)
                            .foregroundStyle(country.viewCountry == "Colombia" ? .purple : .primary)
                    }
                }
                
                // 数字代表输出顺序
                Button("Change third to Colombia") {
                    Task {
                        print(2)
                        await moc.perform { // 挂起，直到 perform块执行完毕
                            print(3)
                            let country = countries[2]
                            country.country = "Colombia"
                            try! moc.save()
                        }
                        print(4) // await 执行完毕，才能执行
                    }
                    print(1)
                }
            }
            .navigationTitle("Await Perform")
        }
    }
}

#Preview {
    AwaitPerform()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
