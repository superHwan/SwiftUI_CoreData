//
//  SFR_ChangeSectionId.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/24.
//
// 实例属性：sectionIdentifier 的使用

import SwiftUI
import CoreData

struct SFR_ChangeSectionId: View {
    
    @SectionedFetchRequest<String?, ParkEntity>(sectionIdentifier: \.country,
                                                sortDescriptors: [NSSortDescriptor(keyPath: \ParkEntity.country, ascending: true)])
    private var parks
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var regionId = false
    
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
                    Text(section.id!)
                }
                .headerProminence(.increased) // header的样式加大加粗
                
            }
            .navigationTitle("Parks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        regionId.toggle()
                        
                        if regionId {
                            parks.sectionIdentifier = \.region
                            parks.sortDescriptors = [SortDescriptor(\.region)] // 可选
                        } else {
                            parks.sectionIdentifier = \.country
                            parks.sortDescriptors = [SortDescriptor(\.country)] // 可选
                        }
                        
                    } label: {
                        Image(systemName: regionId ? "mappin.circle" : "globe")
                    }
                }
            }
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
