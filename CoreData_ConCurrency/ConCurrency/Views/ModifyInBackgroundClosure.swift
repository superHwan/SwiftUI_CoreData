//
//  ModifyInBackgroundClosure.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/12.
//

/*
 规则：与对应 context 相同线程内执行 Core Data 的任务
 冲突：context-主线程，任务-后台线程
 - 没有设置抛出并发问题：能在不同线程修改值，没有提醒异常
 - 设置抛出并发问题：不能在不同线程修改值，有异常提醒
 设置：EditScheme - Run - Arguments - 勾选 ConcurrencyDebug
 问题：
 1. 同一线程：undo() 能逐个地撤销
 2. 不同线程：能修改值，undo() 一次性撤销当前所有操作（违反Core Data 线程安全规则）
 但并没有抛出异常，此时需 启动多线程断言
 */

import SwiftUI

struct ModifyInBackgroundClosure: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: [])
    private var countries
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(countries) { country in
                        Text(country.viewCountry)
                    }
                }
                
                Button("Wrong: Change first to Norway") {
                    let country = countries[0] // 主线程上创建实例，属于主上下文
                    // 后台线程，用户主动发起的、要立即看到结果的操作
                    DispatchQueue.global(qos: .userInitiated).async { // 后台线程操作 主线程的对象
                        country.country = "Norway" // 触发 多线程断言
                        try! moc.save()
                    }
                }
                
                Button("Correct: Change second to Iceland") {
                    let country = countries[1] // 主线程上创建的实例，属于主上下文
                    // 主线程
                    DispatchQueue.global(qos: .userInitiated).async {
                        moc.perform {
                            country.country = "Iceland" // 不触发 多线程断言
                            try! moc.save()
                        }
                    }
                }
            }
            .navigationTitle("Different thread")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button { // 用于没有设置并发异常提醒时，恢复原始状态
                        moc.undo()
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }

                    Button { // 保存按钮
                        try? moc.save()
                    } label: {
                        Image(systemName: "checkmark")
                    }

                }
            }
        }
        .onAppear {
            moc.undoManager = UndoManager()
        }
        .onDisappear {
            moc.undoManager = nil
        }
    }
}

#Preview {
    ModifyInBackgroundClosure()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
