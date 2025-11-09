//
//  ManufacturerEntity+Extensions.swift
//  Relationships
//
//  Created by Sanny on 2025/11/5.
//

extension ManufacturerEntity {
    var viewName: String {
        name ?? "N/A" // Not Available
    }
    
    var viewCountry: String {
        country ?? "[Not Specified]"
    }
    
    // MARK: Relationships
    var viewAutoEntities: [AutoEntity] {
        return autoEntities?.allObjects as? [AutoEntity] ?? [] // 无序的 to-Many 自动生成的类型为 NSSet? --可修改的表示方式-> Set<ManufacturerEntity>
//        return autoEntities?.array as? [AutoEntity] ?? [] // 有序的 to-Many 自动生成的类型为 NSOrderedSet? --可修改的表示方式-> Array<ManufacturerEntity>
    }
    
    // MARK: Sorted
    var viewSortedAutos: [AutoEntity] {
        let autos = autoEntities?.allObjects as? [AutoEntity] ?? [] // 无勾选Ordered
//        let autos = autoEntities?.array as? [AutoEntity] ?? [] // 有Ordered
        
        return autos.sorted { auto1, auto2 in
            auto1.viewModel.uppercased() < auto2.viewModel.uppercased()
        }
    }
}
