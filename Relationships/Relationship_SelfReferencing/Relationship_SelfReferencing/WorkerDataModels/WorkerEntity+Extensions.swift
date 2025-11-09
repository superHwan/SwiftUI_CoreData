//
//  WorkerEntity+Extensions.swift
//  Relationship_SelfReferencing
//
//  Created by Sanny on 2025/11/9.
//

extension WorkerEntity {
    var viewName: String {
        name ?? "N/A"
    }
    
    var viewSubordinates: [WorkerEntity]? {
        // 处理To-Many指向数据不存在的情况
        if let subordinates, subordinates.count > 0 {
            return subordinates.allObjects as? [WorkerEntity]
        }
        return nil
    }
    
    /// 无效排序：子级数据的 data  均为  <fault>
    var viewSortedSubordinates: [WorkerEntity]? {
        // 处理To-Many指向数据不存在的情况
        guard let subordinates, subordinates.count > 0 else {
            return nil
        }
        
        let subs = subordinates.allObjects as? [WorkerEntity] ?? []
        return subs.sorted {
            $0.viewName > $1.viewName
        }
    }
}
