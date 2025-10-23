//
//  ProgrammaticFilter.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/23.
//
// nsPredicate属性 + 按钮切换

import SwiftUI

struct ProgrammaticFilter: View {
    @State private var justUnitedStates = false
    @FetchRequest(sortDescriptors: []) private var parks: FetchedResults<ParkEntity>
    @Environment(\.managedObjectContext) private var viewContext
    
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
            .toolbar {
                ToolbarItem { // 用于更改predicate
                    Button {
                        justUnitedStates.toggle()
                        parks.nsPredicate = justUnitedStates ? NSPredicate(format: "country == 'United States'") : nil
                    } label: {
                        Image(systemName: justUnitedStates ? "globe.americas.fill" : "globe.americas")
                    }
                }
            }
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
