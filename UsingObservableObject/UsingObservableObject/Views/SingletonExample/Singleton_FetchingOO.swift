//
//  Singleton_FetchingOO.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/26.
//

import Foundation
import CoreData

class Singleton_FetchingOO: ObservableObject {
    let moc: NSManagedObjectContext = CoreDataStack.shared.managedObjectContext
    @Published var users: [UserEntity] = []
    @Published var deletedError: Error?
    
    func fetch() {
        let request = UserEntity.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \UserEntity.firstName, ascending: true)]
        
        if let fetchedUsers = try? moc.fetch(request) {
            self.users = fetchedUsers
        }
    }
    
    /// 删除：先从 moc 中删除，再从 @Published 属性中删除
    func delete(offsets: IndexSet) {
        var deletedAtIndex: Int?
        
        // 视图为滑动删除，故有无 break 不影响，都是仅删除一个；当为 选择多个项目后执行删除，break 会产生影响
        for offset in offsets {
//            print("user: \(users[offset])") // 验证 @Published 的不同步
            
            moc.delete(users[offset])
            deletedAtIndex = offset
            
//            print("moc.hasChanges: \(moc.hasChanges)") // 验证 @Published 的不同步
            break // 一次删除多个元素时，可启用
        }
        
        do {
            try moc.save()
            // 启用/停用该段：验证 @Published 不同步导致的情况
            if let index = deletedAtIndex {
                users.remove(at: index)
            }
        } catch {
            deletedError = error
        }
    }
    
    /// 新增
    func insert(user: User) {
        let userEntity = UserEntity(context: moc)
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.age = Int16(user.age)
        userEntity.imageURL = user.imageURL
        
        do {
            try moc.save()
            
            users.append(userEntity) // @Published 同步
        } catch {
            print("Failed to insert new user.")
        }
    }
    
    /// 更新实例对象的属性值
    func update() {
        do {
            try moc.save()
            
            // 引用类型下 @Published 修饰的属性已经更新，只需引发视图重绘
            objectWillChange.send()
        } catch {
            print("Failed to update the user.")
        }
    }
}
