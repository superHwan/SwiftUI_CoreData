//
//  ContentView.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("OP:/n Click on a certain datamodel - Inspector(Right Size) - Model Version Curren")
                Text("Curr: ParkDataModel 3 - all views")
                Text("Curr: ParkDataModel 2 - Version2 & Version1")
                Text("Curr: ParkDataModel 1 - Version1")
                NavigationLink("Version 1", destination: Version1())
                NavigationLink("Version 2", destination: Version2())
                NavigationLink("Version 3", destination: Version3())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
