//
//  NewManufacturerView.swift
//  Relationship_ToMany
//
//  Created by Sanny on 2025/11/7.
//
// ManufacturerEntity中属性默认为 Optional，故 name/country 可不赋值

import SwiftUI

struct NewManufacturerView: View {
    @State private var name: String = ""
    @State private var country: String = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            Text("New Manufacturer")
                .font(.largeTitle)
                .bold()
            
            TextField("Manufacturer's Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 5)
            
            TextField("Manufacturer's Country", text: $country)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 5)
            
            Button("Save") {
                // 存储数据在 memory
                let newManufacturer = ManufacturerEntity(context: moc)
                newManufacturer.name = name
                if !country.isEmpty {
                    newManufacturer.country = country
                }
                // 保存修改到持久化存储
                do {
                    try moc.save()
                    dismiss()
                } catch {
                    fatalError("Failed to save new manufacturer: \(error.localizedDescription)")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.isEmpty) // 要求 name 不为空
            
            Spacer()
        }
        .padding()
        .background(Color(.secondarySystemBackground))
    }
}

#Preview {
    NewManufacturerView()
}
