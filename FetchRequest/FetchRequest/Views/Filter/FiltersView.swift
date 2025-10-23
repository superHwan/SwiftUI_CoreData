//
//  FiltersView.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/22.
//
// 单/多个筛选条件

import SwiftUI

struct FiltersView: View {
    @FetchRequest<ParkEntity>(
        sortDescriptors: [],
        predicate: NSPredicate(format: "country = %@", "Canada")
    )
    private var singleFileterParks
    
    @FetchRequest<ParkEntity>(
        sortDescriptors: [],
        predicate: NSPredicate(format: "country == 'Canada' AND region == 'Alberta'")
    )
    private var multipleFilterParks

    var body: some View {
        NavigationStack {
            NavigationLink("Single Filter：Canada", destination: ConfigurationView(parks: singleFileterParks))
            NavigationLink("Multiple Filters：Canada AND Alberta", destination: ConfigurationView(parks: multipleFilterParks))
            
            NavigationLink("Filter with nsPredicate + Button：United States", destination: ProgrammaticFilter())
            
            NavigationLink("Filter with nsPredicate + searchable：keyword", destination: FilteringWithSearchable())
        }
        
    }
}
