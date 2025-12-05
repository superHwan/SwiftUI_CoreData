//
//  AppDataTransformer.swift
//  Transforming
//
//  Created by Sanny on 2025/12/3.
//
import Foundation
import UIKit

class AppDataTransformer: NSSecureUnarchiveFromDataTransformer {
    // Make sure you types are in the allowed class list
    override static var allowedTopLevelClasses: [AnyClass] {
        return [UIColor.self, UIImage.self, MotorcycleTechnicalSpecification.self]
    }
    
    /// Registers the transformer.
    public static func register() {
        let name = NSValueTransformerName(rawValue: String(describing: AppDataTransformer.self)) // 用作标识符
        ValueTransformer.setValueTransformer(AppDataTransformer(), forName: name)
    }
}
