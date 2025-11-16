//
//  CoreDataStack.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//

import CoreData

class CoreDataStack: ObservableObject {
    
    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext // 需多次请求后台上下文时，推荐使用
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "CountriesDataModel")
        
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, _ in }
        
        backgroundContext = persistentContainer.newBackgroundContext()
        
        // viewContext 会自动合并对持久存储所做的更改（使后台上下文的更改与 viewContext 同步（更新UI））
//        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        if forPreview {
            addMockData(to: persistentContainer.viewContext)
        }
    }
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // 写法一（不推荐）
    static var previewInMemory = CoreDataStack(forPreview: true).managedObjectContext
    
    // 写法二，能够根据不同的编译配置提供不同的单例实例
    static var shared: CoreDataStack {
        return sharedCountriesContainer
    }
    private static var sharedCountriesContainer: CoreDataStack = {
        #if DEBUG
            return CoreDataStack(forPreview: true)
        #else
            return CoreDataStack()
        #endif
    }()
}

extension CoreDataStack {
    func addMockData(to moc: NSManagedObjectContext) {
        // 数据源
        let countries: [(countryName: String, cityName: String, year: Int, month: Int, day: Int, hour: Int, minute: Int)] = [
            ("Japan", "Tokyo", 2005, 3, 15, 8, 45),
            ("Canada", "Toronto", 2010, 7, 22, 14, 30),
            ("Sweden", "Stockholm", 2015, 11, 5, 9, 15),
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
