//
//  Constraint_GetError.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//
// 处理一：呈现错误信息(转型，再对错误的 userInfo 属性 的 键NSPersistentStoreSaveConflictsErrorKey 获得 约束冲突数组，再对该数组进行处理)
// 处理二：删除该导致错误的对象

import SwiftUI
import CoreData

struct Constraint_GetError: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest<CountryEntity>(sortDescriptors: [SortDescriptor(\.lastVisited)])
    private var countries
    
    @State private var countryName: String = ""
    @State private var cityName: String = ""
    // 用于记录错误信息
    @State private var validationError = ""
    @State private var duplicatesError = ""
    
    var body: some View {
        VStack {
            TextField("City Name", text: $cityName)
                .textFieldStyle(.roundedBorder)
            TextField("Country Name", text: $countryName)
                .textFieldStyle(.roundedBorder)
            
            Button {
                // 清空可能已有的错误信息
                validationError = ""
                duplicatesError = ""
                
                let newCountry = CountryEntity(context: moc)
                newCountry.country = countryName
                newCountry.city = cityName
                newCountry.lastVisited = Date()
                
                do {
                    // 已赋值，安全清理；放try后cityName无法清
                    countryName = ""
                    cityName = ""
                    
                    try moc.save()
                } catch let e as CocoaError {
                    let errorDictionary = e.userInfo // 通过userInfo字典 获取错误信息
                    
                    if let conflictList = errorDictionary[NSPersistentStoreSaveConflictsErrorKey] { // 通过键检查是否存在约束冲突列表
                        let constraintConflicts = conflictList as! [NSConstraintConflict] // 强转冲突列表，以使用NSConstraintConflict类型的属性
                        
                        for conflict in constraintConflicts {
                            validationError = "Constraint violation(s) from: " + conflict.constraint.joined(separator: ", ") // constraint 获得违反的约束名称
                            
                            // constraintValues 获得 冲突对象名，及创建时导致冲突所具有的值
                            var duplicates: [String] = []
                            for (propertyName, value) in conflict.constraintValues {
                                duplicates.append("The \(propertyName) filed should have a unique value.\n'\(value)' already exists.")
                            }
                            
                            duplicatesError = duplicates.joined(separator: "\n")
                        }
                        
                        moc.delete(newCountry) // 删除引起错误的对象，避免引起UI刷新
                    }
                } catch {
                    validationError = error.localizedDescription
                }
                
                countryName = ""
            } label: {
                Text("Add")
            }
            .buttonStyle(.borderedProminent)
            
            // 异常信息
            VStack(alignment: .leading) {
                Text(validationError).foregroundStyle(.red)
                Text(duplicatesError).foregroundStyle(.red)
            }
            
            List(countries) { country in
                Text("\(country.viewCity), \(country.viewCountry)")
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    Constraint_GetError()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
