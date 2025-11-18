//
//  AutosDataImporter.swift
//  Relationships
//
//  Created by Sanny on 2025/11/4.
//
// 导入 Manufacturer 和 Auto 部分的数据

import SwiftUI
import CoreData

internal enum AutosDataImporter {
    
    /// 导入初始数据
    static func importAutosData(to moc: NSManagedObjectContext) async throws {
        // 确保数据只导入一次
        guard UserDefaults.standard.bool(forKey: "autoAlreadyRun") == false else {
            return
        }
        
        UserDefaults.standard.set(true, forKey: "autoAlreadyRun")
        
        try await addManufacturerAndAuto(to: moc)
    }
    
    /// 用于预览的模拟数据
    static func addMockData(to moc: NSManagedObjectContext) async throws {
        
        // 确保数据只导入一次
        guard UserDefaults.standard.bool(forKey: "mockDataAlreadyRun") == false else {
            return
        }
        
        UserDefaults.standard.set(true, forKey: "mockDataAlreadyRun")
        
        try await addManufacturerAndAuto(to: moc)
    }
    
    /// 添加制造商及其汽车数据
    private static func addManufacturerAndAuto(to moc: NSManagedObjectContext) async throws{
        try await moc.perform {
            for maker in CarsMaker.allCases {
                // ManufacturerEntity
                let manufacturer = addManufacturer(moc: moc, name: maker.rawValue, country: maker.country)
                // AutoEntity
                addAutos(moc: moc, manufacturer: manufacturer, autoInfos: maker.autosData)
            }
            
            try moc.save()
        }
    }
    
    /// 汽车数据
    /// 不使用 async，因为已在perform块中执行
    @discardableResult
    private static func addAuto(moc: NSManagedObjectContext, manufacturer: ManufacturerEntity, autoInfo: AutoInfo) -> AutoEntity {
        let auto = AutoEntity(context: moc)
        auto.manufacturerUUID = manufacturer.uuid
        auto.manufacturer = manufacturer.name // 不推荐这样，应传rawValue 值
        auto.model = autoInfo.model
        auto.year = autoInfo.year
        auto.price = Int32(autoInfo.price)
        return auto
    }
    @discardableResult
    private static func addAutos(moc: NSManagedObjectContext, manufacturer: ManufacturerEntity, autoInfos: [AutoInfo]) -> [AutoEntity] {
        let autoEntities: [AutoEntity] = autoInfos.map { autoInfo in
            let auto = AutoEntity(context: moc)
            auto.manufacturer = manufacturer.name
            auto.manufacturerUUID = manufacturer.uuid
            auto.model = autoInfo.model
            auto.year = autoInfo.year
            auto.price = Int32(autoInfo.price)
            return auto
        }
        return autoEntities
    }
    
    /// 汽车商 数据
    /// 不使用 async，因为已在perform块中执行
    @discardableResult
    private static func addManufacturer(moc: NSManagedObjectContext, name: String, country: String) -> ManufacturerEntity {
        let manufacturer = ManufacturerEntity(context: moc)
        manufacturer.name = name
        manufacturer.country = country
        manufacturer.uuid = UUID()
//        try? moc.save()
        return manufacturer
    }
}

/// 原始数据
enum CarsMaker: String, CaseIterable {
    case Audi, Toyota, Ford, BMW, Tesla, Hyundai, Benz
    
    var autosData: [AutoInfo] {
        switch self {
        case .Audi:
            return CarsMaker.AUDI_SERIES
        case .Toyota:
            return CarsMaker.TOYOTA_SERIES
        case .Ford:
            return CarsMaker.FORD_SERIES
        case .BMW:
            return CarsMaker.BMW_SERIES
        case .Tesla:
            return CarsMaker.TESLA_SERIES
        case .Hyundai:
            return CarsMaker.HYUNDAI_SERIES
        case .Benz:
            return CarsMaker.BENZ_SERIES
        }
    }
    
    var country: String {
        switch self {
        case .Audi:
            return "Germany"
        case .Toyota:
            return "Japan"
        case .Ford:
            return "USA"
        case .BMW:
            return "Germany"
        case .Tesla:
            return "USA"
        case .Hyundai:
            return "South Korea"
        case .Benz:
            return "Germany"
        }
    }
    
    private static let AUDI_SERIES: [AutoInfo] = [AutoInfo( model: "Q4 e-tron", year: "2024", price: 150_000),
                                                  AutoInfo(model: "e-tron GT", year: "2024", price: 999_800),
                                                  AutoInfo(model: "RS e-tron GT", year: "2024", price: 1_247_800)]
    
    private static let TOYOTA_SERIES: [AutoInfo] = [AutoInfo(model: "Camry", year: "2026", price: 136_800),
                                                    AutoInfo(model: "RAV4", year: "2023", price: 124_800),
                                                    AutoInfo(model: "Prius", year: "2024", price: 220_000)]
    
    private static let FORD_SERIES: [AutoInfo] = [AutoInfo(model: "F-150", year: "2024", price: 280_000),
                                                  AutoInfo(model: "Mustang Mach-E", year: "2024", price: 400_000),
                                                  AutoInfo(model: "Explorer", year: "2023", price: 309_800)]
    
    private static let BMW_SERIES: [AutoInfo] = [AutoInfo(model: "i4", year: "2024", price: 429_900),
                                                 AutoInfo(model: "X5", year: "2023", price: 519_700),
                                                 AutoInfo(model: "3 Series", year: "2023", price: 300_100)]
    
    private static let TESLA_SERIES: [AutoInfo] = [AutoInfo(model: "Model 3", year: "2024", price: 235_500),
                                                   AutoInfo(model: "Model Y", year: "2024", price: 263_500),
                                                   AutoInfo(model: "Cybertruck", year: "2024", price: 570_800)]
    
    private static let HYUNDAI_SERIES: [AutoInfo] = [AutoInfo(model: "Ioniq 5", year: "2024", price: 404_600),
                                                     AutoInfo(model: "Tucson", year: "2023", price: 282_000),
                                                     AutoInfo(model: "Santa Fe", year: "2023", price: 221_300)]
    
    private static let BENZ_SERIES: [AutoInfo] = [AutoInfo(model: "S-Class", year: "2024", price: 1_430_000),
                                                  AutoInfo(model: "E-Class", year: "2023", price: 449_000),
                                                  AutoInfo(model: "GLE", year: "2023", price: 843_800)]
}

struct AutoInfo {
    let model: String
    let year: String
    let price: Int
}
