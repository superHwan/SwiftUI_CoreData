//
//  ContentView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Move the Core Data logic into an observable object")
                NavigationLink("Injection Example", destination: Injection_FetchingView(oo: Injection_FetchingOO(moc: moc)))
                NavigationLink("Singleton Example", destination: Singleton_FetchingView())
                NavigationLink("Function Parameter Example", destination: FP_FetchingView())
                NavigationLink("Delete", destination: DeletingView())
                NavigationLink("Insert", destination: InsertingView())
                NavigationLink("Update", destination: UpdatingView())
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
