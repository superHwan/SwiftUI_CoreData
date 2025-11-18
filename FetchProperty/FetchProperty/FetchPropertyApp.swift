//
//  FetchPropertyApp.swift
//  FetchProperty
//
//  Created by Sanny on 2025/11/16.
//

import SwiftUI

@main
struct FetchPropertyApp: App {
    @StateObject private var coreDataStack = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.managedObjectContext)
        }
    }
}
