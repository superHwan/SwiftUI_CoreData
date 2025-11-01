//
//  Optional_CannotUpdateToNil.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/11/1.
//
// 预先操作：取消勾选 city 的 Optional
// 不能将已有值改为nil（含撤销undo）

import SwiftUI

struct Optional_CannotUpdateToNil: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    
    @State private var cityName = "" // 用户输入的更改值
    @State private var previousCity = "" // 更改前的原始值
    @State private var selectedCountry: CountryEntity? // 待更改的对象
    @State private var requiredError = ""
    
    
    var body: some View {
        VStack {
            TextField("Select One to Edit", text: $cityName)
                .textFieldStyle(.roundedBorder)
            
            Button("Update") {
                if let selected = selectedCountry {
                    // 更改为最新值
                    selected.city = cityName.isEmpty ? nil : cityName
                    
                    // 保存 + 异常处理，撤销
                    do {
                        try moc.save()
                        cityName = ""
                        selectedCountry = nil
                        requiredError = ""
                    } catch {
                        requiredError = error.localizedDescription.firstUppercased
                        selected.city = previousCity
                    }
                }
            }
            
            Text(requiredError)
                .font(.title)
                .foregroundStyle(.red)
            
            List(countries) { country in
                Text(country.viewCity)
                    .foregroundStyle(selectedCountry == country ? .red : .primary)
                    .onTapGesture {
                        previousCity = country.viewCity
                        selectedCountry = country
                    }
            }
        }
    }
}

#Preview {
    Optional_CannotUpdateToNil()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
