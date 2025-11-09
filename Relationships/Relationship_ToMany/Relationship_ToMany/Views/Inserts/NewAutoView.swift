//
//  NewAutoView.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// 关键：addToAutoEntities() 的使用

import SwiftUI

struct NewAutoView: View {
    var manufacturer: ManufacturerEntity
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var model = ""
    @State private var year = ""
    
    
    var body: some View {
        VStack {
            Text("New Auto")
                .font(.largeTitle)
                .bold()
            
            HStack {
                TextField("Year", text: $year)
                    .frame(width: 100)
                TextField("Model", text: $model)
            }
            .textFieldStyle(.roundedBorder)
            
            Button("Save") {
                let newAuto = AutoEntity(context: moc)
                newAuto.model = model
                newAuto.year = year
                manufacturer.addToAutoEntities(newAuto) // 使用系统自动生成的方法，建立关系
                
                do {
                    try moc.save()
                    dismiss()
                } catch {
                    fatalError("Failed to save new auto data: \(error.localizedDescription)")
                }
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
    }
}
