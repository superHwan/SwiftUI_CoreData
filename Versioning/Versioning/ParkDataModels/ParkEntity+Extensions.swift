//
//  ParkEntity+Extensions.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

import UIKit

extension ParkEntity {
    var viewCountry: String {
        country ?? "[Enter Country]"
    }
    var viewName: String {
        name ?? "N/A"
    }
    var viewRegion: String {
        region ?? "[Enter Region]"
    }
    
    /// DataModel v1 / v2: ParkEntity-image(A)
    var viewImage: UIImage {
        // 运行时检查，value(forKey:) 检查属性是否存在
        // v1/v2
        if responds(to: NSSelectorFromString("image")) { // 检查属性是否存在
            if let imageName = self.value(forKey: "image") as? String, let image = UIImage(named: imageName) {
                return image
            }
        }
        // 运行v3，查看v1/v2下的视图
        if let imageEntity = imageEntities?.allObjects.first as? ImageEntity,
           let imageName = imageEntity.image,
           let image = UIImage(named: imageName) {
            return image
        }
        
        return UIImage(systemName: "photo")!
    }
    
    var viewLocation: String {
        "\(viewRegion), \(viewCountry)"
    }
    
    /// DataModel v2+
    var viewRating: String {
        if let rating = self.value(forKey: "rating") as? Int {
            return "\(rating).circle.fill"
        }
        return ""
    }
    
    /// DataModel v3: ParkEntity-imageEntities(R), ImageEntity-image(A)
    var viewImageNames: [String] {
        // 运行时检查，value(forKey:) 检查属性是否存在，存在则进行类型转换
        if let imageEntities = self.value(forKey: "imageEntities") as? Set<ImageEntity> {
            var imageNames: [String] = []
            // imageEntities(Relationship): imageEntity.image(String) -> UIImage
            for imageEntity in imageEntities {
                if let imageName = imageEntity.image {
                    imageNames.append(imageName)
                }
            }
            return imageNames
        }
        return ["photo"]
    }
}
