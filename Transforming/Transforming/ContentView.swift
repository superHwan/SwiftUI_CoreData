//
//  ContentView.swift
//  Transforming
//
//  Created by Sanny on 2025/12/3.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Key code files: AppDataTransformer, CoreDataStack, MotorcycleEntity, MotorcycleTechnicalSpecification")
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .lineSpacing(10)
                
                NavigationLink("Existing Type: UIImage, UIColor", destination: ImageAndColorView())
                NavigationLink("Custom Type: MotorcycleTechnicalSpecification", destination: CustomClassView())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
