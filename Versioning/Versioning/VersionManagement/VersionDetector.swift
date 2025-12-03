//
//  VersionDetector.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//
// 跟踪当前的 Model Version Identifier

import CoreData

class VersionDetector {
    /// 获取当前使用的数据模型的 标识符（Model Version Identifier）
    static func getCurrentVersionIdentifier(context: NSManagedObjectContext) -> String? {
        // 获得当前模型
        guard let moderl = context.persistentStoreCoordinator?.managedObjectModel else {
            return nil
        }
        // 获取版本标识
        return moderl.versionIdentifiers.first as? String
    }
}
