//
//  TechSpecsView.swift
//  Transforming
//
//  Created by Sanny on 2025/12/4.
//

import SwiftUI

struct TechSpecsView: View {
    var horsepoint: Int
    var weight: Measurement<UnitMass>
    var engine: String
    
    var body: some View {
        Form {
            Section("Type") {
                Text(engine)
            }
            Section("Power") {
                Text("\(horsepoint) hp")
            }
            Section("Wet weight no fuel") {
                Text(weight, format: .measurement(width: .abbreviated))
            }
        }
    }
}
