//
//  UpdateUserView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/27.
//

import SwiftUI

struct UpdateUserView: View {
    let oo: Singleton_FetchingOO
    @Binding var selectedUser: UserEntity?
    @Environment(\.dismiss) var dismiss
    
    // MARK: 待修改的属性值
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var age: Double = 0
    @State private var imageURL = ""
    
    var body: some View {
        VStack {
            Text("Update User Info")
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
                if let user = selectedUser {
                    user.firstName = firstname
                    user.lastName = lastname
                    user.age = Int16(age)
                    user.imageURL = imageURL
                }
                
                oo.update()
                
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .disabled(firstname.isEmpty || lastname.isEmpty)
        }
        .frame(maxHeight: .infinity)
        .background(Color(.secondarySystemBackground))
        .onAppear {
            if let user = selectedUser {
                firstname = user.viewFirstName
                lastname = user.viewLastName
                age = Double(user.age)
                imageURL = user.viewImageURL
            }
        }
    }
}
