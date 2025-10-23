//
//  ConfigurationView.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/22.
//

import SwiftUI
import CoreData

struct ConfigurationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var parks: FetchedResults<ParkEntity>
    
    init(parks: FetchedResults<ParkEntity>) {
        self.parks = parks
    }
    
    var body: some View {
        NavigationStack {
            List(parks) { park in
                HStack {
                    Image(uiImage: park.viewImage)
                        .resizable()
                        .frame(width: 80, height: 60)
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(park.viewName)
                            Spacer()
                            Image(systemName: park.viewRating)
                        }
                        .font(.title)
                        Text(park.viewLocation)
                            .fontWeight(.light)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("Parks")
        }
        .task {
            do {
                try await ParkDataImporter.importParks(to: viewContext)
            } catch {
                print("Failed to load data:", error.localizedDescription)
            }
        }
    }
}
