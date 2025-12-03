//
//  CoreDataStack+Extensions.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

extension CoreDataStack {
    func setupMockData() async throws {
        guard let versionIdentifier = VersionDetector.getCurrentVersionIdentifier(context: managedObjectContext) else {
            print("无法检测到版本标识符（Model Version Identifier）")
            return
        }
        
        let dataImporter = ParkVersionFactory.getDataImporter(for: versionIdentifier)
        print("当前使用的数据模型版本：\(versionIdentifier)")
        
        try await dataImporter.addParkMockData(to: managedObjectContext)
    }
}
