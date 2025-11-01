//
//  DataModelInspectorApp.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//

import SwiftUI

@main
struct DataModelInspectorApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    @StateObject private var animalCoreDataStack = CoreDataStack(modelName: "AnimalsDataModel")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
                .task {
                    do {
                        try await CountryDataImporter.importCountryData(to: coreDataStack.managedObjectContext)
                    } catch {
                        fatalError("Failed to load country data: \(error.localizedDescription)")
                    }
                }
        }
    }
}
