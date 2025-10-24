//
//  ContentView.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 8) {
                NavigationLink("Use of sectionIdentifier", destination: SFR_Intro())
                NavigationLink("computed property -> sectionIdentifier", destination: SFR_ComputedProperty())
                NavigationLink("Changing sectionIdentifier", destination: SFR_ChangeSectionId())
                NavigationLink("Parks Count", destination: SFR_Count())
            }
        }
    }
}

#Preview {
    ContentView()
}
