//
//  Version1.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

import SwiftUI

struct Version1: View {
    @FetchRequest<ParkEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var parks
    
    var body: some View {
        NavigationView {
            List(parks) { park in
                HStack {
                    Image(uiImage: park.viewImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading) {
                        Text(park.viewName)
                            .font(.title)
                        Text(park.viewLocation)
                    }
                }
            }
            .navigationTitle("Park Version 1")
        }
    }
}

#Preview {
    Version1()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
