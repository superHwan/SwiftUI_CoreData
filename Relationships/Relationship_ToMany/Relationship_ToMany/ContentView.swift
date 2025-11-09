//
//  ContentView.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                NavigationLink("Dispaly: NavigationLink", destination: ParentChild())
                NavigationLink("Dispaly: Section", destination: NestedDisplay())
                NavigationLink("Dispaly: SectionedFetchRequest", destination: SectionedFetchRequestView())
                NavigationLink("Ordered Or Not", destination: OrderedOrNot())
                NavigationLink("Sorted Or Not", destination: SortedOrNot())
                NavigationLink("Insert Parents", destination: InsertingParent())
                NavigationLink("Insert Children", destination: InsertingChildren())
                Text("Please manually set the 'Delete Rule'")
                NavigationLink("Delete Rule: Nullify", destination: NullifyRule())
                NavigationLink("Delete Rule: Cascade", destination: CascadeRule())
                NavigationLink("Delete Rule: Deny", destination: DenyRule())
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
