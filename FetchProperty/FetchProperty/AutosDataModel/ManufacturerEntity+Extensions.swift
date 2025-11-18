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
}

// 由于存在多个key，赋名时可用Enum，避免错误
extension ManufacturerEntity {
    var viewManufacturersWithoutBMW: [ManufacturerEntity] {
        let manufacturers = self.value(forKey: "manufacturersWithoutBMW") as? [ManufacturerEntity]
        
        return manufacturers ?? []
    }
    
    var viewManufacturersInSameCountry: [ManufacturerEntity] {
        let manufacturers = self.value(forKey: "manufacturersInSameCountry") as? [ManufacturerEntity]
        return manufacturers ?? []
    }
    
    var viewAutos: [AutoEntity] {
        let autos = self.value(forKey: "autos") as? [AutoEntity]
        return autos ?? []
    }
    
    var viewAutos_Wrong: [AutoEntity] {
        let autos = self.value(forKey: "autos_wrong") as? [AutoEntity]
        return autos ?? []
    }
    
    var viewAutosInIdealPrice: [AutoEntity] {
        let autos = self.value(forKey: "autosInIdealPrice") as? [AutoEntity]
        return autos ?? []
    }
}
