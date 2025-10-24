//
//  ExtensionParkEntity.swift
//  SectionedFetchRequest
//
//  Created by Sun on 2025/10/24.
//
// Handle nils and formatting
import CoreData
import UIKit

extension ParkEntity {
    var viewImage: UIImage {
        if let data = image, let image = UIImage(data: data) {
            return image
        } else {
            return UIImage(systemName: "photo")!
        }
    }
    
    var viewName: String {
        name ?? "[No Park Name]"
    }
    
    var viewRegion: String {
        region ?? "N/A"
    }
    
    @objc // 计算属性用作 节标识符
    var viewCountry: String {
        country ?? "N/A"
    }
    
    var viewLocation: String {
        viewRegion + ", " + viewCountry
    }
    
    var viewRating: String {
        "\(rating).circle.fill"
    }
}
