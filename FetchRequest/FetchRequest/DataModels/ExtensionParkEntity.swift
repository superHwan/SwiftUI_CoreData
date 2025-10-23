//
//  ExtensionParkEntity.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/20.
//

import UIKit
import CoreData

// 用于视图：处理 nil 并 格式化
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
