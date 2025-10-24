//
//  SFR_Intro.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/24.
//
/*
 1. sectionIdentifier 的用途 -> header，字体加大加粗
 2. sortDescriptors：组间按country，组内按rating
 3. 增加搜索栏
 */
import SwiftUI
import CoreData

struct SFR_Intro: View {
    // 排序：组间按country，组内按rating
    @SectionedFetchRequest<String?, ParkEntity>(sectionIdentifier: \.country,
                                                sortDescriptors: [NSSortDescriptor(keyPath: \ParkEntity.country, ascending: true),
                                                                  NSSortDescriptor(keyPath: \ParkEntity.rating, ascending: true)])
    private var parks
    
    @Environment(\.managedObjectContext) var moc
    @State private var searchText = ""
    
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
                    if let countryName = section.id {
                        Text(countryName)
                    } else {
                        Text("N/A")
                    }
                }
                
            }
            .headerProminence(.increased) // header的样式加大加粗
//            .listStyle(.plain)
            .navigationTitle("Parks")
            
            // 增加搜索栏
            .searchable(text: $searchText)
            .onChange(of: searchText) { _, newValue in
                // nil 用于恢复原始视图
                parks.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "name CONTAINS %@ OR country CONTAINS %@", newValue, newValue)
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
