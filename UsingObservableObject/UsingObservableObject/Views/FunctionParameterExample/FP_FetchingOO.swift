//
//  FP_FetchingOO.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/26.
//

import Foundation
import CoreData

class FP_FetchingOO: ObservableObject {
    @Published var users: [UserEntity] = []
    
    func fetch(by moc: NSManagedObjectContext) {
        let request = UserEntity.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \UserEntity.age, ascending: true)]
        
        if let fetchedUsers = try? moc.fetch(request) {
            self.users = fetchedUsers
        }
    }
}
