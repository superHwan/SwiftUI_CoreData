//
//  Version3.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

import SwiftUI

struct Version3: View {
    @FetchRequest<ParkEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var parks
    
    var body: some View {
        NavigationView {
            List(parks) { park in
                NavigationLink {
                    DetailImageView(parkName: park.viewName, imageNames: park.viewImageNames)
                } label: {
                    HStack {
                        Image(park.viewImageNames.first!)
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
            }
            .navigationTitle("Park Version 3")
        }
    }
}

#Preview {
    Version3()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
