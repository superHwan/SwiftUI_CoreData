//
//  FilteringWithSearchable.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/23.
//
// nsPredicate属性 + 搜索栏

import SwiftUI

struct FilteringWithSearchable: View {
    @State private var searchText = ""
    @FetchRequest<ParkEntity>(sortDescriptors: []) private var parks
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
            // 添加关键词搜索栏
            .searchable(text: $searchText)
            .onChange(of: searchText) { oldValue, newValue in
                parks.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "name CONTAINS %@", newValue)
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
