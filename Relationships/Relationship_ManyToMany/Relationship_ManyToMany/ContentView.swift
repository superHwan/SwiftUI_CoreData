//
//  ContentView.swift
//  Relationship_ManyToMany
//
//  Created by Sanny on 2025/11/7.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ManyToMany()
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.previewForSchoolDataModel)
}
