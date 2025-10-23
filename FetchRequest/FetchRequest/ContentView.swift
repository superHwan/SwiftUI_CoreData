//
//  ContentView.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/19.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            NavigationLink("Sort", destination: SortsView())
            NavigationLink("Filter", destination: FiltersView())
            NavigationLink("Extension of the FetchRequest", destination: FRsView())
        }
    }
}

#Preview {
    ContentView()
}
