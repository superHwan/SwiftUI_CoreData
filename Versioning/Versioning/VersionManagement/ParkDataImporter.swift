//
//  ParkDataImporter.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//
import CoreData

/// 单一版本的数据导入器
struct ParkDataImporter {
    func addParkMockData(to moc: NSManagedObjectContext) async throws {
        try await moc.perform {
            let sampleParks = getSampleParks() // 获取初始数据
            for park in sampleParks {
                let parkEntity = ParkEntity(context: moc)
                parkEntity.name = park.name
                parkEntity.region = park.region
                parkEntity.country = park.country
                // 由于此段会报异常，故注销，实际使用打开 Value of type 'ParkEntity' has no memeber 'image'
//                parkEntity.image = park.image
                // 实际使用时注销
                if parkEntity.responds(to: NSSelectorFromString("image")) {
                    parkEntity.setValue(park.image, forKey: "image")
                }
            }
            
            try moc.save()
        }
    }
    
    /// 从 enum ParkName 中获取初始数据
    private func getSampleParks() -> [Park] {
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
    
    private func getSampleParks_V2() -> [Park] {
        var sampleParks: [Park] = []
        
        sampleParks = ParkName.allCases.map { park in
            let name = park.rawValue.replacing("_", with: " ")
            
            var newPark = Park(name: name,
                               region: park.parkLocation.region,
                               country: park.parkLocation.region,
                               image: park.rawValue)
            
            newPark.rating = park.parkRating
            
            return newPark
        }
        
        return sampleParks
    }
}
