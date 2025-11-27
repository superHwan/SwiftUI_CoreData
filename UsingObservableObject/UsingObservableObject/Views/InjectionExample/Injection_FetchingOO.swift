//
//  Injection_FetchingOO.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/26.
//
import Foundation
import CoreData

class Injection_FetchingOO: ObservableObject {
    let moc: NSManagedObjectContext
    @Published var users: [UserEntity] = [] // 实体对象
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    /// 获取实例对象
    func fetch() {
        let request = UserEntity.fetchRequest() // 获取 fetch request 对象
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \UserEntity.age, ascending: true)]
        
        if let fetchedUsers = try? moc.fetch(request) {
            self.users = fetchedUsers
        } else {
            print("moc fetch error")
        }
    }
}
