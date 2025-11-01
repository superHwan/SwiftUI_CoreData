//
//  CountryDataImporter.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//
// 导入原始数据，视图间共享且只导入一次
// 在调用处统一处理错误，提供更清晰的错误传播路径（在 task导入数据处处理）
import CoreData

internal enum CountryDataImporter {
    static func importCountryData(to moc: NSManagedObjectContext) async throws {
        
        guard UserDefaults.standard.bool(forKey: "alreadyRun") == false else {
            return
        }
        
        // 将键置为true，再次进入时，直接return
        UserDefaults.standard.set(true, forKey: "alreadyRun")
        
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
        
        // 保存
        try moc.save()
    }
}
