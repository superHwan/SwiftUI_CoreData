//
//  ContentView.swift
//  FetchProperty
//
//  Created by Sanny on 2025/11/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink("Basic Usage", destination: WithPredicate())
                NavigationLink("Manufacturer in same country", destination: TheSpecificManagedObject())
                NavigationLink("Connecting Two Entities", destination: ConnectingTwoEntities())
                NavigationLink {
                    ConnectingEntitiesWithCondition()
                } label: {
                    Text("Present autos from the specified manufacturer that are lower than the idealPrice set by userInfo")
                }

            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
