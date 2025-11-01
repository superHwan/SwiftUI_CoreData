//
//  ContentView.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Constraints: Duplicates -> Crash", destination: Constraint_Intro())
            NavigationLink("Constraints: Duplicates -> Error Alert", destination: Constraint_GetError())
        }
    }
}

#Preview {
    ContentView()
}
