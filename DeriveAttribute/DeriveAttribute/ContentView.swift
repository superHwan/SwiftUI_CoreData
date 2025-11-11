//
//  ContentView.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/9.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("String Functions", destination: StringFunctionsView())
            NavigationLink("Aggregate Operations", destination: AggregateOperationsView())
            NavigationLink("Recompute on save", destination: RecomputeOnSaveView())
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
