//
//  ContentView.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Undo: Basic", destination: MOC_Undo())
            NavigationLink("Undo: hasChanges", destination: MOC_Undo_HasChanges())
            NavigationLink("Undo: Scope", destination: MOC_Undo_Scope())
            NavigationLink("Undo: levelsOfUndo 2", destination: MOC_Undo_Scope())
            NavigationLink("Rollback", destination: MOC_Rollback())
            NavigationLink("Redo", destination: MOC_Redo())
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
