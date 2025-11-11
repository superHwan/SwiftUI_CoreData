//
//  BeachesDataInitializer.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/9.
//
// 暂时还没深入探索 JSON 解析逻辑，下面直接导入

import CoreData

struct BeachesDataInitializer {
    public static func importBeachesData(to moc: NSManagedObjectContext) async throws {
        guard UserDefaults.standard.bool(forKey: "BeachesDataModelAlreadyRun") == false else {
            return
        }
        UserDefaults.standard.set(true, forKey: "BeachesDataModelAlreadyRun")
        
        try await addData(to: moc)
    }
    
    public static func addMockDataToBeaches(to moc: NSManagedObjectContext) {
        Task {
            do {
                try await addData(to: moc)
            } catch {
                print("Failed to load mock data: \(error.localizedDescription)")
            }
        }
    }
    
    private static func addData(to moc: NSManagedObjectContext) async throws {
        
        for country in Country.allCases {
            // NationEntity 实体
            let newNation = NationEntity(context: moc)
            newNation.name = country.rawValue
            
            // [BeachEntity] 实体
            let beachEntities = importBeaches(country.beachesData, to: moc)
            // 建立对多的关系：NationEntity 拥有beachEntities 关系（To-Many）
//            newNation.addToBeachEntities(NSSet(array: beachEntities))
            newNation.beachEntities = NSSet(array: beachEntities)
            // 建立对单的关系：BeachEntity 拥有 nationEntity 关系（To-One）
            for beachEntity in beachEntities {
                beachEntity.nationEntity = newNation
            }
        }
        try moc.save()
        
    }
    
    /// 批量导入海滩数据
    private static func importBeaches(_ beaches: [BeachInfo], to moc: NSManagedObjectContext) -> [BeachEntity] {
        let entites = beaches.map { beachData in
            let newBeach = BeachEntity(context: moc)
            newBeach.name = beachData.name
            newBeach.city = beachData.city
            newBeach.rating = beachData.rating
            return newBeach
        }
        return entites
    }
}

enum Country: String, CaseIterable {
    case Germany, Italy, Brazil, American, Seychelles, China
    
    var beachesData: [BeachInfo] {
        switch self {
        case .American:
            return Country.USA_BEACHES
        case .Brazil:
            return Country.BRAZIL_BEACHES
        case .China:
            return Country.CHINA_BEACHES
        case .Seychelles:
            return Country.SHYCHELLES_BEACHES
        case .Germany:
            return Country.GERMANY_BEACHES
        default:
            return Country.ITALY_BEACHES
        }
    }
    
    // 静态变量：所有数据
    private static let USA_BEACHES: [BeachInfo] = transformToBeachInfo(AmericanBeaches)
    private static let AmericanBeaches: OriginalType = [
        ("Venice Beach", "Los Angeles", 4.0),
        ("Waikiki Beach", "Honolulu", 4.2),
        ("South Beach", "Miami", 4.1),
        ("Newport Beach", "Newport Beach", 3.9),
        ("Coronado Beach", "San Diego", 4.3),
        ("Hanauma Bay Beach", "Honolulu", 4.4),
        ("Malibu Beach", "Malibu", 4.0),
        ("Miami Beach", "Miami", 4.2),
        ("Santa Monica Beach", "Santa Monica", 3.8),
        ("Cannon Beach", "Oregon", 4.5)
    ]
    
    private static let CHINA_BEACHES: [BeachInfo] = transformToBeachInfo(ChineseBeaches)
    private static let ChineseBeaches: OriginalType = [
        ("Honeymoon Bay", "Sanya", 4.2),
        ("Yalong Bay", "Sanya", 4.1),
        ("Shimao Beach", "Sanya", 3.9),
        ("Jinshitan Beach", "Dalian", 4.0),
        ("Qingdao Beach", "Qingdao", 3.8)
    ]
    
    private static let SHYCHELLES_BEACHES: [BeachInfo] = transformToBeachInfo(ShychellessBeaches)
    private static let ShychellessBeaches: OriginalType = [
        ("Anse Source d'Argent", "La Digue", 4.5),
        ("Anse Lazio", "Praslin", 4.4),
        ("Anse Intendance", "Praslin", 4.3),
        ("Anse Georgette", "Praslin", 4.2),
        ("Anse Major", "Praslin", 4.1)
    ]
    
    private static let BRAZIL_BEACHES: [BeachInfo] = transformToBeachInfo(BrazilsBeaches)
    private static let BrazilsBeaches: OriginalType = [
        ("Praia do Forte", "Fortaleza", 4.1),
        ("Praia de Ipanema", "Rio de Janeiro", 4.3),
        ("Praia de Copacabana", "Rio de Janeiro", 4.0),
        ("Praia de Jericoacoara", "Jericoacoara", 4.5),
        ("Praia de Fernando de Noronha", "Fernando de Noronha", 4.4),
        ("Praia de Trancoso", "Bahia", 4.2),
        ("Praia de Pipa", "Tibau do Sul", 3.6),
        ("Praia de Arraial do Cabo", "Arraial do Cabo", 4.1),
        ("Ferradura Beach", "ARMAÇÃO DOS BÚZIOS", 4.3)
    ]
    
    private static let ITALY_BEACHES: [BeachInfo] = transformToBeachInfo(ItalianBeaches)
    private static let ItalianBeaches: OriginalType = [
        ("Portofino Beach", "Portofino", 4.5),
        ("Cala di Forno", "Sardinia", 4.2),
        ("Baia di San Teodoro", "Sardinia", 4.0),
        ("Spiaggia di Spiaggia", "Sicily", 3.8),
        ("Cala Goloritz", "Sardinia", 4.4),
        ("Spiaggia di Grotta Nera", "Sardinia", 4.1),
        ("Spiaggia di Porto Cervo", "Sardinia", 4.3),
        ("Spiaggia di La Cinta", "Sardinia", 4.0),
        ("Spiaggia di La Pelosa", "Sardinia", 4.2),
        ("Spiaggia di La Saline", "Sardinia", 3.9)
    ]
    
    private static let GERMANY_BEACHES: [BeachInfo] = transformToBeachInfo(GermanBeaches)
    private static let GermanBeaches: OriginalType = [
        ("Timmendorfer Strand", "Timmendorfer Strand", 4.2),
        ("Flaucher", "München", 4.0),
        ("Isar Beach", "München", 3.8),
        ("Düsseldorfer Badeplatz", "Düsseldorf", 3.9),
        ("Köln Beach", "Köln", 3.7),
        ("Münchener Stadtbad", "München", 4.1)
    ]
    
    typealias OriginalType = [(String, String, Double)]
    private static func transformToBeachInfo(_ arr: OriginalType) -> [BeachInfo] {
        arr.map { (name, city, rating) in
            BeachInfo(name: name, city: city, rating: rating)
        }
    }
}

struct BeachInfo {
    let name: String
    let city: String
    let rating: Double
}
/*
 Germany
 ["Timmendorfer Strand", "Timmendorfer Strand", 4.2],
 ["Flaucher", "München", 4.0],
 ["Isar Beach", "München", 3.8],
 ["Düsseldorfer Badeplatz", "Düsseldorf", 3.9],
 ["Köln Beach", "Köln", 3.7],
 ["Münchener Stadtbad", "München", 4.1]
 Italy
 ["Portofino Beach", "Portofino", 4.5],
 ["Cala di Forno", "Sardinia", 4.2],
 ["Baia di San Teodoro", "Sardinia", 4.0],
 ["Spiaggia di Spiaggia", "Sicily", 3.8],
 ["Cala Goloritz", "Sardinia", 4.4],
 ["Spiaggia di Grotta Nera", "Sardinia", 4.1],
 ["Spiaggia di Porto Cervo", "Sardinia", 4.3],
 ["Spiaggia di La Cinta", "Sardinia", 4.0],
 ["Spiaggia di La Pelosa", "Sardinia", 4.2],
 ["Spiaggia di La Saline", "Sardinia", 3.9]
 Brazil:
 ["Praia do Forte", "Fortaleza", 4.1],
 ["Praia de Ipanema", "Rio de Janeiro", 4.3],
 ["Praia de Copacabana", "Rio de Janeiro", 4.0],
 ["Praia de Jericoacoara", "Jericoacoara", 4.5],
 ["Praia de Fernando de Noronha", "Fernando de Noronha", 4.4],
 ["Praia de Trancoso", "Bahia", 4.2],
 ["Praia de Pipa", "Tibau do Sul", 3.6],
 ["Praia de Arraial do Cabo", "Arraial do Cabo", 4.1]
 ["Ferradura Beach", "ARMAÇÃO DOS BÚZIOS", 4.3]
 United States:
 ["Venice Beach", "Los Angeles", 4.0],
 ["Waikiki Beach", "Honolulu", 4.2],
 ["South Beach", "Miami", 4.1],
 ["Newport Beach", "Newport Beach", 3.9],
 ["Coronado Beach", "San Diego", 4.3],
 ["Hanauma Bay Beach", "Honolulu", 4.4],
 ["Malibu Beach", "Malibu", 4.0],
 ["Miami Beach", "Miami", 4.2],
 ["Santa Monica Beach", "Santa Monica", 3.8],
 ["Cannon Beach", "Oregon", 4.5]
 Seychelles:
 ["Anse Source d'Argent", "La Digue", 4.5],
 ["Anse Lazio", "Praslin", 4.4],
 ["Anse Intendance", "Praslin", 4.3],
 ["Anse Georgette", "Praslin", 4.2],
 ["Anse Major", "Praslin", 4.1]
 China:
 ["Honeymoon Bay", "Sanya", 4.2],
 ["Yalong Bay", "Sanya", 4.1],
 ["Shimao Beach", "Sanya", 3.9],
 ["Jinshitan Beach", "Dalian", 4.0],
 ["Qingdao Beach", "Qingdao", 3.8]
 */
