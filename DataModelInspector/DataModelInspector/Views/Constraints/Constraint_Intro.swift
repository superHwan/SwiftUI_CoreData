//
//  Constraint_Intro.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//

import SwiftUI

struct Constraint_Intro: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest<CountryEntity>(sortDescriptors: [SortDescriptor(\.lastVisited)])
    private var countries
    
    @State private var countryName: String = ""
    
    var body: some View {
        VStack {
            TextField("Country Name", text: $countryName)
                .textFieldStyle(.roundedBorder)
            
            Button {
                let newCountry = CountryEntity(context: moc)
                newCountry.country = countryName
                newCountry.lastVisited = Date()
                
                try? moc.save() // 返nil -> 保存到memory，UI刷新，但不会保存到持久化存储
//                try! moc.save() // 强制解包 -> app crash(NSConstraintConflict for constraint (\n    name\n))
                
                countryName = ""
            } label: {
                Text("Add")
            }
            .buttonStyle(.borderedProminent)

            
            List(countries) { country in
                Text(country.viewCountry)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    Constraint_Intro()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
