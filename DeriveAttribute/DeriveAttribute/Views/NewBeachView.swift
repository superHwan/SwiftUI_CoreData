//
//  NewBeachView.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/11.
//

import SwiftUI

struct NewBeachView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    let nation: NationEntity
    @State private var name: String = ""
    @State private var city: String = ""
    @State private var ratingString: String = ""
    
    var body: some View {
        VStack {
            Text("New Beach")
                .font(.largeTitle)
                .bold()
            TextField("Beach's name", text: $name)
            TextField("City of the beach", text: $city)
            TextField("Rating (0-5)", text: $ratingString)
            
            Button("Upload") {
                // 新增 BeachEntity
                let beach = BeachEntity(context: moc)
                beach.name = name
                beach.city = city
                let rating = Double(ratingString) ?? 0.00 // 假设填入的就是数字
                beach.rating = rating
                // 建立关系
                nation.addToBeachEntities(beach)
                beach.nationEntity = nation
                // 关闭页面
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .disabled(name.isEmpty || city.isEmpty || ratingString.isEmpty)
            
            Spacer()
        }
        .textFieldStyle(.roundedBorder)
        .padding()
        .background(Color(.secondarySystemBackground))
    }
}
