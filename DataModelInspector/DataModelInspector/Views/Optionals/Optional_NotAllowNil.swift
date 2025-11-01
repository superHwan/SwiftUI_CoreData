//
//  Optional_NotAllowNil.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/11/1.
//
// 预先操作：取消勾选 city 的 Optional
// 不能输入 Nil

import SwiftUI

struct Optional_NotAllowNil: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: [SortDescriptor(\.city)]) private var countries
    
    @State private var cityName = ""
    @State private var requiredError = ""
    
    var body: some View {
        VStack {
            TextField("City Name", text: $cityName)
                .textFieldStyle(.roundedBorder)
            
            Button("Add") {
                let newCountry = CountryEntity(context: moc)
                
                if !cityName.isEmpty {
                    newCountry.city = cityName
                }
                
                // 异常处理
                do {
                    try moc.save()
                    cityName = ""
                } catch {
                    requiredError = error.localizedDescription.firstUppercased
                    moc.delete(newCountry) // 避免UI刷新
                }
            }
            .buttonStyle(.bordered)
            
            Text(requiredError)
                .font(.title)
                .foregroundStyle(.red)
            
            List(countries) { country in
                Text(country.viewCity)
            }
        }
    }
}

#Preview {
    Optional_NotAllowNil()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
