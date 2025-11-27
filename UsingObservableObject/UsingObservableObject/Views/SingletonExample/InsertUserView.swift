//
//  InsertUserView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/27.
//

import SwiftUI

struct InsertUserView: View {
    let oo: Singleton_FetchingOO
    @Environment(\.dismiss) var dismiss
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var age: Double = 0
    @State private var imageURL = ""
    
    var body: some View {
        VStack {
            Text("New User Info")
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 10) {
                TextField("user's firstname", text: $firstname)
                TextField("user's lastname", text: $lastname)
                TextField("user's imageURL", text: $imageURL)
                HStack {
                    Text("age: \(Int(age))")
                    Slider(value: $age, in: 0...150, step: 1)
                }
                
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            
            Button("Save") {
                // 数据处理
                if imageURL == "" {
                    imageURL = "https://dummyjson.com/icon/emilys/128"
                }
                
                let newUser = User(firstName: firstname, lastName: lastname, age: Int(age), imageURL: imageURL)
                oo.insert(user: newUser)
                
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .disabled(firstname.isEmpty || lastname.isEmpty)
        }
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}
