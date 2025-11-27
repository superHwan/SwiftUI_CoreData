//
//  UserService.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/20.
//
// 解码并存储到 Core Data
import Foundation

struct UserService {
    static let usersAbsolutePath = "/Users/sun/Desktop/swiftProject/swiftBooks/CoreData/cdm-code/UsingObservableObject/UsingObservableObject/Resources/users.json"
    
    func fetchFromAPI(_ urlString: String = "https://dummyjson.com/users") async throws {
        // 获取数据 + 网络响应
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlString)!)
        
        // 检查网络响应
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // 解码
        guard let decodedUsersData = try? JSONDecoder().decode(Users.self, from: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        // 使用后台线程进行数据导入
        let bgContext = CoreDataStack.shared.backgroundContext
        try await bgContext.perform {
            for user in decodedUsersData.users {
                let userEntity = UserEntity(context: bgContext)
                userEntity.firstName = user.firstName
                userEntity.lastName = user.lastName
                userEntity.age = Int16(user.age)
                userEntity.imageURL = user.imageURL
            }
            
            try bgContext.save()
        }
    }
    
    func fetchUsersFromLocal() async throws {
        let decodedUsersData = try fetchFromLocal(fileName: "users", type: Users.self)
        
        // 使用后台线程进行数据导入
        let bgContext = CoreDataStack.shared.backgroundContext
        try await bgContext.perform {
            for user in decodedUsersData.users {
                let userEntity = UserEntity(context: bgContext)
                userEntity.firstName = user.firstName
                userEntity.lastName = user.lastName
                userEntity.age = Int16(user.age)
                userEntity.imageURL = user.imageURL
            }
            
            try bgContext.save()
        }
    }
    
    private func fetchFromLocal<T: Decodable>(fileName: String, fileExtension: String = "json", type: T.Type) throws -> T {
        // 获取数据
//        guard let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) else {
//            throw NSError(domain: "FileNotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "JSON 文件未找到"])
//        }
//        
//        let url = URL(filePath: path)
//        
//        let jsonData = try Data(contentsOf: url)
        
        
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            throw NSError(domain: "FileNotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "JSON 文件未找到"])
        }
        
        let jsonData = try Data(contentsOf: fileURL)
        
        // 解码
        let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
        return decodedData
    }
    
    func fetchJSONFromAbsolutePath(_ absolutePath: String = usersAbsolutePath) async throws {
        let fileURL = URL(filePath: absolutePath)
        
        guard FileManager.default.fileExists(atPath: absolutePath) else {
            throw NSError(domain: "FileNotFound", code: 404, userInfo: [NSLocalizedDescriptionKey: "绝对路径未找到 JSON 文件"])
        }
        
        let jsonData = try Data(contentsOf: fileURL)
        
        // 解码
        let decodedUsersData = try JSONDecoder().decode(Users.self, from: jsonData)
        
        // 使用后台线程进行数据导入
        let bgContext = CoreDataStack.shared.backgroundContext
        try await bgContext.perform {
            for user in decodedUsersData.users {
                let userEntity = UserEntity(context: bgContext)
                userEntity.firstName = user.firstName
                userEntity.lastName = user.lastName
                userEntity.age = Int16(user.age)
                userEntity.imageURL = user.imageURL
            }
            
            try bgContext.save()
        }
    }
}
