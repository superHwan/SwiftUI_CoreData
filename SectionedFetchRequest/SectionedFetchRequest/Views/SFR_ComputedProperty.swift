//
//  SFR_ComputedProperty.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/24.
//

// using a computed property as a section identifier
// @objc viewCountry

import SwiftUI

struct SFR_ComputedProperty: View {
    // 排序：组间按country，组内按rating
    @SectionedFetchRequest<String, ParkEntity>(sectionIdentifier: \.viewCountry,
                                                sortDescriptors: [NSSortDescriptor(keyPath: \ParkEntity.country, ascending: true),
                                                                  NSSortDescriptor(keyPath: \ParkEntity.rating, ascending: true)])
    private var parks
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            List(parks) { section in
                Section {
                    ForEach(section) { park in
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
                } header: {
                    // sectionIdentifier 的使用
                    Text(section.id)
                }
                
            }
            .headerProminence(.increased) // header的样式加大加粗
            .navigationTitle("Parks")
        }
        .task {
            do {
                try await ParkDataImporter.importParks(to: moc)
            } catch {
                print("Failed to load data:", error.localizedDescription)
            }
        }
    }
}
