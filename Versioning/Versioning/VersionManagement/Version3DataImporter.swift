//
//  Version3DataImporter.swift
//  Versioning
//
//  Created by Sanny on 2025/12/3.
//
// 版本3的模拟数据生成器

import CoreData

struct Version3DataImporter: ParkDataVersionHandler {
    /// 以 enum Park 为基础，添加基础一张图片
    func addParkMockData(to moc: NSManagedObjectContext) async throws {
        try await moc.perform {
            let sampleParks = getSampleParks() // 获取初始数据
            for park in sampleParks {
                let parkEntity = ParkEntity(context: moc)
                parkEntity.name = park.name
                parkEntity.region = park.region
                parkEntity.country = park.country
                parkEntity.rating = Int16(park.rating!)
                
                // 新实体
                // 内建在 ParkEntity 的主图
                let imageEntity = ImageEntity(context: moc)
                imageEntity.image = park.image
                parkEntity.addToImageEntities(imageEntity) // 建立关系
                // 细节图
                if let detailImages = park.detailImages {
                    for detailImage in detailImages {
                        let imageEntity = ImageEntity(context: moc)
                        imageEntity.image = detailImage
                        parkEntity.addToImageEntities(imageEntity) // 建立关系
                    }
                }
                
                // 建立关系 ImageEntity 下 parkEntity 关系
                imageEntity.parkEntity = parkEntity
            }
            
            try moc.save()
        }
    }
    
    func getSampleParks() -> [Park] {
        var sampleParks: [Park] = []
        
        sampleParks = ParkName.allCases.map { park in
            let name = park.rawValue.replacing("_", with: " ")
            
            let newPark = Park(name: name,
                               region: park.parkLocation.region,
                               country: park.parkLocation.region,
                               image: park.rawValue,
                               rating: park.parkRating,
                               detailImages: park.detailImageNames) // detailImages - 用于 v3 Relationship
            
            return newPark
        }
        
        return sampleParks
    }
}
