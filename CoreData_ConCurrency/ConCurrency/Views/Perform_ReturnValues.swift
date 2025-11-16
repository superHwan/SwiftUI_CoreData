//
//  Perform_ReturnValues.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/13.
//
// perform(schedule:_:) 的使用
// 

import SwiftUI

struct Perform_ReturnValues: View {
    @Environment(\.managedObjectContext) var moc
    @State private var countries: [CountryEntity] = []
    
    var body: some View {
        VStack {
            Button("Get Four Countries") {
                Task {
                    countries = try await moc.perform {
                        var results: [CountryEntity] = []
                        
                        let request = CountryEntity.fetchRequest()
                        request.fetchLimit = 4
                        
                        try request.execute().forEach { countryEntity in
                            results.append(countryEntity)
                        }
                        
                        return results
                    }
                }
            }
            
            List(countries) { country in
                Text(country.viewCountry)
            }
        }
    }
}

#Preview {
    Perform_ReturnValues()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
