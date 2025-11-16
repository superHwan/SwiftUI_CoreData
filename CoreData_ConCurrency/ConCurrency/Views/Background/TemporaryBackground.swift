//
//  TemporaryBackground.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/15.
//

import SwiftUI

struct TemporaryBackground: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: []) private var countries
    
    var body: some View {
        VStack {
            List {
                ForEach(countries) { country in
                    Text(country.viewCountry)
                        .foregroundStyle(country.viewCountry == "Greece" ? .blue : .primary)
                }
            }
            
            Button("Refresh") {
                moc.automaticallyMergesChangesFromParent = true
                
                let container = CoreDataStack.shared.persistentContainer
                
                container.performBackgroundTask { backgroundContext in
                    let newCountry = CountryEntity(context: backgroundContext)
                    newCountry.country = "Greece"
                    
                    try! backgroundContext.save()
                }
            }
        }
    }
}

#Preview {
    TemporaryBackground()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
