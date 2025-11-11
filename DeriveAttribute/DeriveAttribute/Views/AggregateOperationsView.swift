//
//  AggregateOperationsView.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/11.
//
// count/sum 的使用
import SwiftUI

struct AggregateOperationsView: View {
    @FetchRequest<NationEntity>(sortDescriptors: [])
    private var nations
    
    var body: some View {
        NavigationStack {
            List(nations) { nation in
                NavigationLink {
                    List(nation.viewBeachEntities) { beach in
                        Text(beach.viewName)
                    }
                    .navigationTitle("\(nation.viewName)")
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(nation.viewName)
                                .font(.title)
                            Text(nation.viewAverageRating) // Derived( Double(beachCount) / beachEntities.rating.@sum)
                            Text(nation.viewLastUpdated) // Derived Attribute
                                .foregroundStyle(.gray)
                        }
                    }
                    .badge(Int(nation.beachCount))  // Derived (count:(beachEntities))
                }

            }
            .navigationTitle("Aggregate Operations")
        }
    }
}

#Preview {
    AggregateOperationsView()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
