//
//  MockDataImporter.swift
//  Transforming
//
//  Created by Sanny on 2025/12/4.
//

import CoreData
import UIKit

struct MockDataImporter {
    
    func addMotorcycleMockData(to moc: NSManagedObjectContext) async throws {
        try await moc.perform {
            for motorcycle in MotorcycleName.allCases {
                let motorcycleEntity = MotorcycleEntity(context: moc)
                let name = motorcycle.rawValue.replacing("_", with: " ")
                motorcycleEntity.name = name
                motorcycleEntity.color = motorcycle.color
                motorcycleEntity.image = UIImage(named: motorcycle.rawValue)
                motorcycleEntity.specs = MotorcycleTechnicalSpecification(hp: motorcycle.horsepower,
                                                                          weight: motorcycle.weightNoFuel,
                                                                          engineDescription: motorcycle.engineDescription)
            }
            
            try moc.save()
        }
    }
}
