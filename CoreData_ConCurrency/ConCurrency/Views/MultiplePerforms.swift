//
//  MultiplePerforms.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/13.
//
// perform 可确保 Core Data 任务 是在 正确的串行队列上 一个接一个地完成

import SwiftUI
import CoreData

struct MultiplePerforms: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<CountryEntity>(sortDescriptors: [])
    private var countries
    
    var body: some View {
        VStack(spacing: 20) {
            List {
                ForEach(countries) { country in
                    Text(country.viewCountry)
                        .foregroundStyle(country.viewCountry == "Australia" ? .red : .primary)
                }
            }
            
            // 输出：1 2 3 4 5 6
            // 即使 updateCountry 中 perform 延迟 1s，deleteCountry 的 perform 仍晚于其运行
            Button("perform: Update & Delete") {
                let selectedCountry = countries[0].objectID
                Task {
                    await updateCountry(objectId: selectedCountry)
                }
                // 二者间隔4s，才能看到 update 的效果（UI刷新）
                Task {
                    await deleteCountry(objectId: selectedCountry)
                }
            }
            
            // 由于 f1 中 延迟 1s，故 f2 先运行完毕
            Button("Two Async Functions") {
                Task {
                    await f1() // 延迟 1s，后输出 f1()
                }
                Task {
                    await f2() // 先输出f2()
                }
            }
        }
    }
    
    private func f1() async {
        try! await Task.sleep(nanoseconds: 1_000_000_000) // 延迟 1s
        print("f1()")
    }
    
    private func f2() async {
        print("f2()")
    }
    
    // 有先后顺序的 perform 块需一个接一个地执行，perform 块外无此要求
    private func updateCountry(objectId: NSManagedObjectID) async {
        print(1)
        
        await moc.perform {
            print(3)
            Thread.sleep(forTimeInterval: 1) // 延迟 1s
            do {
                let country = try moc.existingObject(with: objectId) as! CountryEntity
                country.country = "Australia"
                try moc.save()
            } catch {
                print(error.localizedDescription)
            }
            print(4)
        }
    }
    
    private func deleteCountry(objectId: NSManagedObjectID) async {
        print(2)
        
        await moc.perform {
            print(5)
//            Thread.sleep(forTimeInterval: 5)
            do {
                let country = try moc.existingObject(with: objectId) as! CountryEntity
                moc.delete(country)
                try moc.save()
            } catch {
                print(error.localizedDescription)
            }
            print(6)
        }
    }
    
}

#Preview {
    MultiplePerforms()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
