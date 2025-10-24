//
//  SectionedFetchRequestApp.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/23.
//

import SwiftUI

@main
struct SectionedFetchRequestApp: App {
    private var container = ParkContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, container.managedObjectContext)
        }
    }
}
