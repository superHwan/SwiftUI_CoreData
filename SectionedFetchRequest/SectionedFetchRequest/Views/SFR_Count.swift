//
//  SFR_Count.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/24.
//

import SwiftUI

struct SFR_Count: View {
    @SectionedFetchRequest<String, ParkEntity>(sectionIdentifier: \.viewCountry,
                                               sortDescriptors: [SortDescriptor(\.country)])
    private var parks
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(parks) { section in
                        LabeledContent(section.id, value: "\(section.count)")
                    }
                } footer: {
                    LabeledContent("Country Count", value: "\(parks.count)")
                }
            }
            .navigationTitle("Parks Count")
        }
    }
}
