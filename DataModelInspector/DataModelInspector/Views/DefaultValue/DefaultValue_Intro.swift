//
//  DefaultValue_Intro.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/11/1.
//
// 预备步骤：country 属性 勾选Default Value，并赋值“No Country Enter”
// 赋nil 和 不赋值，观察是否使用到 default value

import SwiftUI

struct DefaultValue_Intro: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    
    @State private var countryName = ""
    @State private var requiredError = "" // 此处应无异常
    
    var body: some View {
        VStack {
            TextField("Country Name", text: $countryName)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                Button("Add Nil") { // 应显示 "N/A"
                    let newCountry = CountryEntity(context: moc)
                    // 输入为空时，赋nil
                    newCountry.country = countryName.isEmpty ? nil : countryName
                    
                    do {
                        try moc.save()
                        countryName = ""
                        requiredError = ""
                    } catch {
                        requiredError = error.localizedDescription
                        moc.delete(newCountry)
                    }
                }
                
                Button("Add Nothing") { // 应显示 "No Country Enter"
                    let newCountry = CountryEntity(context: moc)
                    
                    if !countryName.isEmpty {
                        newCountry.country = countryName
                    }
                    
                    do {
                        try moc.save()
                        countryName = ""
                        requiredError = ""
                    } catch {
                        requiredError = error.localizedDescription
                        moc.delete(newCountry)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Text(requiredError)
                .foregroundStyle(.red)
            
            List(countries) { country in
                Text(country.viewCountry)
                    .foregroundStyle(country.viewCountry == "N/A" ? .blue : (country.viewCountry == "No Country Enter" ? .green : .primary))
            }
        }
    }
}

#Preview {
    DefaultValue_Intro()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
