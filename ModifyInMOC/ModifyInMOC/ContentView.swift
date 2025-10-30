//
//  ContentView.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Delete", destination: MOC_Delete())
            NavigationLink("Update done", destination: MOC_UpdateDone())
            NavigationLink("Update Task", destination: MOC_UpdateTask())
            NavigationLink("Add New Task", destination: MOC_Insert())
            NavigationLink("Summary", destination: MOC_TaskOps())
        }
    }
}

#Preview {
    ContentView()
}
