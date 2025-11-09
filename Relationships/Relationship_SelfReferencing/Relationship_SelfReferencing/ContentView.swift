//
//  ContentView.swift
//  Relationship_SelfReferencing
//
//  Created by Sanny on 2025/11/7.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                NavigationLink("Outline Group", destination: OutlineGroupView())
                NavigationLink("List", destination: ListView())
            }
        }
    }
}

#Preview {
    ContentView()
}
