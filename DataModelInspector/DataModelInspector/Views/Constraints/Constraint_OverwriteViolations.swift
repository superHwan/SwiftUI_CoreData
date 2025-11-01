//
//  Constraint_OverwriteViolations.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/31.
//

import SwiftUI
import CoreData

struct Constraint_OverwriteViolations: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: [SortDescriptor(\.lastVisited)]) private var countries
    
    @State private var countryName = ""
    @State private var cityName = ""
    
    var body: some View {
        VStack {
            TextField("City Name", text: $cityName)
                .textFieldStyle(.roundedBorder)
            TextField("Country Name", text: $countryName)
                .textFieldStyle(.roundedBorder)
            
            Button {
                
                let newCountry = CountryEntity(context: moc)
                newCountry.country = countryName
                newCountry.city = cityName
                newCountry.lastVisited = Date()
                
                try! moc.save() // NSMergePolicy 处理异常情况
                
                countryName = ""
                cityName = ""
            } label: {
                Text("Add")
            }
            .buttonStyle(.borderedProminent)
            
            List(countries) { country in
                HStack {
                    Text("\(country.viewCity), \(country.viewCountry)")
                    Spacer()
                    Text(country.viewLastVisited)
                        .foregroundStyle(.gray)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .onAppear { // 其内容应在 CoreDataStack 内设置
//            moc.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // 内存数据胜出
//            moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy // 等同
            
            moc.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy // 持久化存储中数据胜出
        }
    }
}

#Preview {
    Constraint_OverwriteViolations()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
