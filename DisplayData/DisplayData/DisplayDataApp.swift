//
//  DisplayDataApp.swift
//  DisplayData
//
//  Created by Sun on 2025/10/19.
//

import SwiftUI

@main
struct DisplayDataApp: App {
    @Environment(\.scenePhase) var scenePhase // 当前场景的阶段，后台/退出/在界面
    @StateObject private var bookContainer = BookContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            DisplayData()
                .environment(\.managedObjectContext, bookContainer.managedObjectContext)
                .onChange(of: scenePhase) { oldValue, newValue in
                    bookContainer.save() // 当切换至后台/退出时，保存数据
                }
                .onAppear { // 每次运行app就调用并写入数据库
                    addBooks(to: bookContainer)
                }
        }
    }
}
