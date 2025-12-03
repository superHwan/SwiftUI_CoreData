//
//  Version1DataImporter.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//
// 版本1的模拟数据生成器

import CoreData

struct Version1DataImporter: ParkDataVersionHandler {
    
    func addParkMockData(to moc: NSManagedObjectContext) async throws {
        try await moc.perform {
            let sampleParks = getSampleParks() // 获取初始数据
            for park in sampleParks {
                let parkEntity = ParkEntity(context: moc)
                parkEntity.name = park.name
                parkEntity.region = park.region
                parkEntity.country = park.country
//                parkEntity.image = park.image
                if parkEntity.responds(to: NSSelectorFromString("image")) { // 兼容版本2、3
                    parkEntity.setValue(park.image, forKey: "image")
                }
            }
            
            try moc.save()
        }
    }
    
    /// 从 enum ParkName 中获取初始数据
    func getSampleParks() -> [Park] {
        var sampleParks: [Park] = []
        
        sampleParks = ParkName.allCases.map { park in
            let name = park.rawValue.replacing("_", with: " ")
            
            let newPark = Park(name: name,
                               region: park.parkLocation.region,
                               country: park.parkLocation.region,
                               image: park.rawValue)
            
            return newPark
        }
        
        return sampleParks
    }
}
