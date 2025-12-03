//
//  Version2.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

import SwiftUI

struct Version2: View {
    @FetchRequest<ParkEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var parks
    
    var body: some View {
        NavigationView {
            List(parks) { park in
                HStack {
                    Image(uiImage: park.viewImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Text(park.viewName)
                            Spacer()
                            Image(systemName: park.viewRating)
                        }
                        .font(.title)
                        
                        Text(park.viewLocation)
                    }
                }
            }
            .navigationTitle("Park Version 2")
        }
    }
}

#Preview {
    Version2()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
