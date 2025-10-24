//
//  ParkDataImporter.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/23.
//
// 导入数据

import CoreData
import UIKit

struct ParkDataImporter {
    static func importParks(to managedObjectContext: NSManagedObjectContext) async throws {
        // 仅在第一次运行时将数据写入数据库，第一次运行后将 alreadyRun 设为true
        guard UserDefaults.standard.bool(forKey: "alreadyRun") == false else {
            return
        }
        UserDefaults.standard.set(true, forKey: "alreadyRun")
        
        try await managedObjectContext.perform {
            // 数据源
            let parks: [(name: ParksName, region: String, country: String, rating: Int16, imageName: ParksName)] = [
                (ParksName.Dolomites, "Belluno", "Italy", 1, ParksName.Dolomites),
                (ParksName.Jasper, "Alberta", "Canada", 2, ParksName.Jasper),
                (ParksName.Banff, "Alberta", "Canada", 3, ParksName.Banff),
                (ParksName.Swiss, "Zernez", "Switzerland", 4, ParksName.Swiss),
                (ParksName.Zion, "Utah", "United States", 5, imageName: ParksName.Zion),
                (ParksName.Jiuzhaigou, "Sichuan", "China", 6, ParksName.Jiuzhaigou),
                (ParksName.Yosemite, "California", "United States", 7, ParksName.Yosemite),
                (ParksName.Yellowstone, "Wyoming", "United States", 8, ParksName.Yellowstone),
                (ParksName.Arches, "Utah", "United States", 9, ParksName.Arches),
                (ParksName.Abel_Tasman, "South Island", country: "New Zealand", 10, ParksName.Abel_Tasman),
                (ParksName.Grand_Teton, "Wyoming", "United States", 11, ParksName.Grand_Teton),
                (ParksName.Dartmoor, "Devon", "United Kingdom", 12, ParksName.Dartmoor),
                (ParksName.Bavarian_Forest, "Bavaria", "Germany", 13, ParksName.Bavarian_Forest),
            ]
            
            // 配置属性
            for parkData in parks {
                let park = ParkEntity(context: managedObjectContext)
                park.name = parkData.name.rawValue.replacing("_", with: " ")
                park.region = parkData.region
                park.country = parkData.country
                park.rating = parkData.rating
                guard let image = UIImage(named: parkData.imageName.rawValue), let data = image.jpegData(compressionQuality: 0.8) else {
                    fatalError("Failed to conver image")
                }
                park.image = data
            }
            
            let _ = print("已加载数据")
            
            try managedObjectContext.save()
        }
    }
}

enum ParksName: String {
    case Abel_Tasman
    case Zion
    case Banff
    case Jasper
    case Bavarian_Forest
    case Dartmoor
    case Grand_Teton
    case Dolomites
    case Yellowstone
    case Jiuzhaigou
    case Swiss
    case Yosemite
    case Arches
}
