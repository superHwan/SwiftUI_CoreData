//
//  User.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/20.
//
// JSON 数据的 解码类型

import Foundation

struct User: Decodable {
    var firstName: String
    var lastName: String
    var age: Int
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, age, imageURL = "image"
    }
}

struct Users: Decodable {
    var users: [User]
}
