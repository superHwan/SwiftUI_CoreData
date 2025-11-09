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
    static func importAutosData(to moc: NSManagedObjectContext) async {
        // 确保数据只导入一次
        guard UserDefaults.standard.bool(forKey: "autoAlreadyRun") == false else {
            return
        }
        
        UserDefaults.standard.set(true, forKey: "autoAlreadyRun")
        
        do {
            try await addManufacturer(to: moc)
        } catch {
            moc.rollback() // 回滚到未保存状态
            
            #if DEBUG
            // 开发阶段：中断程序，暴露问题
            fatalError("Failed to import autos data: \(error.localizedDescription)")
            #else 
            // 生产环境：记录日志
            print("Failed to import autos data, restored to initial state: \(error.localizedDescription)")
            // 可自行添加提示/重试逻辑
            #endif
        }
    }
    
    /// 用于预览的模拟数据
    static func addMockData(moc: NSManagedObjectContext) {
        Task {
            do {
                try await addManufacturer(to: moc)
            } catch {
                fatalError("Failed to import autos data: \(error.localizedDescription)")
            }
        }
    }
    
    /// 添加制造商及其关联的汽车数据
    private static func addManufacturer(to moc: NSManagedObjectContext) async throws{
        try await moc.perform {
            let _ = print("start: addManufacturer() perform")
            let audi = ManufacturerEntity(context: moc)
            audi.name = "Audi"
            audi.country = "Germany"
            // 建立关系
            let audis = [addAuto(moc: moc, model: "Q4 e-tron", year: "2024"),
                         addAuto(moc: moc, model: "e-tron GT", year: "2024"),
                         addAuto(moc: moc, model: "RS e-tron GT", year: "2024")]
            audi.autoEntities = NSSet(array: audis)
//            audi.autoEntities = NSOrderedSet(array: audis)
            try audi.validateForUpdate() // 验证数据完整性（由于能保证，故下面不添加）
            
            let toyota = ManufacturerEntity(context: moc)
            toyota.name = "Toyota"
            toyota.country = "Japan"
            let toyotas = [addAuto(moc: moc, model: "Camry", year: "2023"),
                             addAuto(moc: moc, model: "RAV4", year: "2023"),
                             addAuto(moc: moc, model: "Prius", year: "2023")]
            toyota.autoEntities = NSSet(array: toyotas)
//            toyota.autoEntities = NSOrderedSet(array: toyotas)
            
            let ford = ManufacturerEntity(context: moc)
            ford.name = "Ford"
            ford.country = "USA"
            let fords = [addAuto(moc: moc, model: "F-150", year: "2024"),
                         addAuto(moc: moc, model: "Mustang Mach-E", year: "2024"),
                         addAuto(moc: moc, model: "Explorer", year: "2023")]
            ford.autoEntities = NSSet(array: fords)
//            ford.autoEntities = NSOrderedSet(array: fords)
            
            let bmw = ManufacturerEntity(context: moc)
            bmw.name = "BMW"
            bmw.country = "Germany"
            let bmws = [addAuto(moc: moc, model: "i4", year: "2024"),
                        addAuto(moc: moc, model: "X5", year: "2023"),
                        addAuto(moc: moc, model: "3 Series", year: "2023")]
            bmw.autoEntities = NSSet(array: bmws)
//            bmw.autoEntities = NSOrderedSet(array: bmws)

            let tesla = ManufacturerEntity(context: moc)
            tesla.name = "Tesla"
            tesla.country = "USA"
            let teslas = [addAuto(moc: moc, model: "Model 3", year: "2024"),
                          addAuto(moc: moc, model: "Model Y", year: "2024"),
                          addAuto(moc: moc, model: "Cybertruck", year: "2024")]
            tesla.autoEntities = NSSet(array: teslas)
//            tesla.autoEntities = NSOrderedSet(array: teslas)
            
            let hyundai = ManufacturerEntity(context: moc)
            hyundai.name = "Hyundai"
            hyundai.country = "South Korea"
            let hyundais = [addAuto(moc: moc, model: "Ioniq 5", year: "2024"),
                            addAuto(moc: moc, model: "Tucson", year: "2023"),
                            addAuto(moc: moc, model: "Santa Fe", year: "2023")]
            hyundai.autoEntities = NSSet(array: hyundais)
//            hyundai.autoEntities = NSOrderedSet(array: hyundais)
            
            try moc.save()
            
            let _ = print("end: addManufacturer() perform")
        }
    }
    
    /// 汽车数据
    /// 不使用 async，因为已在perform块中执行
    private static func addAuto(moc: NSManagedObjectContext, model: String, year: String) -> AutoEntity {
        let auto = AutoEntity(context: moc)
        auto.model = model
        auto.year = year
//        try auto.validateForUpdate() // 数据验证
        return auto
    }
}
