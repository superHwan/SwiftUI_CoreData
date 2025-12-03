//
//  ParkVersionFactory.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

// 根据检测到的版本返回对应的数据导入器
class ParkVersionFactory {
    static func getDataImporter(for versionIdentifier: String) -> ParkDataVersionHandler {
        switch versionIdentifier {
        case "ParkDataModel_v1":
            return Version1DataImporter()
        case "ParkDataModel_v2":
            return Version2DataImporter()
        case "ParkDataModel_v3":
            return Version3DataImporter()
        default:
            return Version1DataImporter()
        }
    }
}
