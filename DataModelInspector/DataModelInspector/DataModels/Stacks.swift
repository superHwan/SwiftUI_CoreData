//
//  Stacks.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//

import CoreData

extension CoreDataStack {
    /// 内存模式，仅供预览
    public static var previewInMemory: NSManagedObjectContext {
        let container = NSPersistentContainer(name: "CountriesDataModel")
        container.persistentStoreDescriptions.first!.url = URL(filePath: "dev/null")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load the persistent store for preview: \(error.localizedDescription)")
            }
        }
        addMockData(to: container.viewContext)
        return container.viewContext
    }
    
    
    private static func addMockData(to moc: NSManagedObjectContext) {
        // 数据源
        let countries: [(countryName: String, cityName: String, year: Int, month: Int, day: Int, hour: Int, minute: Int)] = [
            ("Japan", "Tokyo", 2005, 3, 15, 8, 45),
            ("Canada", "Toronto", 2010, 7, 22, 14, 30),
            ("Australia", "Sydney", 2015, 11, 5, 9, 15),
            ("Germany", "Berlin", 2008, 2, 14, 17, 50),
            ("Brazil", "Rio de Janeiro", 2020, 6, 30, 12, 10),
            ("South Africa", "Cape Town", 2003, 9, 8, 16, 25),
            ("India", "Mumbai", 2012, 4, 18, 10, 5),
            ("France", "Paris", 2001, 12, 25, 20, 40),
            ("Italy", "Rome", 2018, 8, 8, 7, 55),
            ("United Kingdom", "London", 2023, 5, 1, 13, 20),
            ("China", "HongKong", 2025, 1, 1, 19, 23)
        ]
        
        // 配置属性
        for countryData in countries {
            let country = CountryEntity(context: moc)
            country.country = countryData.countryName
            country.city = countryData.cityName
            country.lastVisited = Calendar.current.date(from: DateComponents(year: countryData.year, month: countryData.month, day: countryData.day, hour: countryData.hour, minute: countryData.minute))
        }
        
        // 保存：内部处理错误
        do {
            try moc.save()
        } catch {
            fatalError("Failed to load mock data: \(error.localizedDescription)")
        }
    }
}
