//
//  TempView.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/15.
//

import SwiftUI
import CoreData

struct TempView: View {
    var body: some View {
        Text("H")
    }
    
    func delCountry(country: CountryEntity) {
        guard let context = country.managedObjectContext else { return }
        context.perform {
            context.delete(country)
            try! context.save()
        }
    }
}
