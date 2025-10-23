//
//  FetchRequestApp.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/19.
//

import SwiftUI

@main
struct FetchRequestApp: App {
    @Environment(\.scenePhase) var scenePahse // 当前场景的阶段，后台/退出/在界面
    private var parksContainer = ParksContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, parksContainer.managedObjectContext)
                .onChange(of: scenePahse) { oldValue, newValue in
                    parksContainer.save() // 当切换至后台/退出时，保存数据
                }
        }
    }
}
