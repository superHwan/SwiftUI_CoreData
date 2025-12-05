//
//  MotorcycleTechnicalSpecification.swift
//  Transforming
//
//  Created by Sanny on 2025/12/4.
//
import ObjectiveC
import Foundation

class MotorcycleTechnicalSpecification: NSObject, NSSecureCoding {
    var horsepower: Int = 100
    var weight: Double = 200.0
    var engine: String = "Waiting for updates."
    
    init(hp: Int, weight: Double, engineDescription: String) {
        self.horsepower = hp
        self.weight = weight
        self.engine = engineDescription
    }
    
    
   // Conforms to NSSecureCoding
    static var supportsSecureCoding: Bool = true
    
    // Conforms to NSSecureCoding: Archive(Type -> Data)
    func encode(with coder: NSCoder) {
        coder.encode(horsepower, forKey: "horsepower")
        coder.encode(weight, forKey: "weight")
        coder.encode(engine, forKey: "engine")
    }
    
    // Conforms to NSSecureCoding: Unarchive(Data -> Type)
    required init?(coder: NSCoder) {
        horsepower = coder.decodeInteger(forKey: "horsepower")
        weight = coder.decodeDouble(forKey: "weight")
        engine = coder.decodeObject(forKey: "engine") as? String ?? "N/A "
    }
}
