//
//  Optional_AllowNil.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/31.
//
// 预先操作：勾选 city 的 Optional

import SwiftUI

struct Optional_AllowNil: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    
    @State private var cityName = ""
    
    var body: some View {
        TextField("City Name", text: $cityName)
            .textFieldStyle(.roundedBorder)
        
        Button("Add") {
            let newCountry = CountryEntity(context: moc)
            
            // 有输入时，赋值（因为 cityName带初始值""，直接赋会显示空）
            if !cityName.isEmpty {
                newCountry.city = cityName
            }
            
            try? moc.save()
            
            cityName = ""
        }
        .buttonStyle(.borderedProminent)
        
        
        List(countries) { country in
            Text(country.viewCity)
                .foregroundStyle(country.viewCity == "N/A" ? .red : .primary)
        }
    }
}

#Preview {
    Optional_AllowNil()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
