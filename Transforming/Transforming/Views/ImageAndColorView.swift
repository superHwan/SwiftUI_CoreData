//
//  ImageAndColorView.swift
//  Transforming
//
//  Created by Sanny on 2025/12/4.
//

import SwiftUI

struct ImageAndColorView: View {
    @FetchRequest<MotorcycleEntity>(sortDescriptors: [])
    private var motorcycles
    
    var body: some View {
        NavigationView {
            List(motorcycles) { motorcycle in
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
            .navigationTitle("Existing Types")
        }
    }
}

#Preview {
    ImageAndColorView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
