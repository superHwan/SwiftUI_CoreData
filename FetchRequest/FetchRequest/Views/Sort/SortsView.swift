//
//  SortsView.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/22.
//

import SwiftUI
import CoreData

struct SortsView: View {
    @FetchRequest(sortDescriptors: [])
    private var randomParks: FetchedResults<ParkEntity>
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ParkEntity.name, ascending: true)])
    private var byNameParks: FetchedResults<ParkEntity>
    
    @FetchRequest<ParkEntity>(sortDescriptors: [SortDescriptor(\.country),
                                                SortDescriptor(\.rating)])
    private var byCountryRatingParks
    
    @FetchRequest<ParkEntity>(sortDescriptors: [SortDescriptor(\.rating, order: .reverse)])
    private var byRatingDescendingParks
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: ConfigurationView(parks: randomParks)) {
                Text("Random Sorting")
            }
            NavigationLink("Sort By Name", destination: ConfigurationView(parks: byNameParks))
            NavigationLink("Sort By Country AND Rating", destination: ConfigurationView(parks: byCountryRatingParks))
            NavigationLink("Sort By Rating in Reverse Order", destination: ConfigurationView(parks: byRatingDescendingParks))
            
        }
    }
}
