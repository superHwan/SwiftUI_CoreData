//
//  CustomClassView.swift
//  Transforming
//
//  Created by Sanny on 2025/12/4.
//

import SwiftUI

struct CustomClassView: View {
    @FetchRequest<MotorcycleEntity>(sortDescriptors: [])
    private var motorcycles
    
    var body: some View {
        NavigationView {
            List(motorcycles) { motorcycle in
                NavigationLink {
                    TechSpecsView(horsepoint: motorcycle.viewHorsepower,
                                  weight: motorcycle.viewWeight,
                                  engine: motorcycle.viewEngine)
                } label: {
                    motorcycle.viewImage
                        .resizable()
                        .scaledToFit()
                        .overlay(alignment: .topLeading) {
                            HStack {
                                Circle()
                                    .foregroundStyle(motorcycle.viewColor)
                                    .frame(width: 30)
                                Text(motorcycle.viewName)
                                    .font(.title)
                                    .foregroundStyle(.gray)
                            }
                        }
                }
            }
            .navigationTitle("Custom Type")
        }
    }
}

#Preview {
    CustomClassView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
