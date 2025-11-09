//
//  Relationship_ManyToManyApp.swift
//  Relationship_ManyToMany
//
//  Created by Sanny on 2025/11/7.
//

import SwiftUI

@main
struct Relationship_ManyToManyApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.schoolManagedObjectContext)
                .task {
                    do {
                        try await SchoolDataInitializer.importSchoolData(to: coreDataStack.schoolManagedObjectContext)
                    } catch {
                        print("Failed to load init data for SchoolDataModel: \(error.localizedDescription)")
                    }
                }
        }
    }
}
