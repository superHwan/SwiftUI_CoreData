//
//  NationEntity+Extensions.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/9.
//
import Foundation

extension NationEntity {
    var viewName: String {
        name ?? "N/A"
    }
    
    var viewBeachEntities: [BeachEntity] {
        beachEntities?.allObjects as? [BeachEntity] ?? []
    }
    
    // 通过循环的方式，获得To-Many 关系的属性值
    var viewBeachNames: [String] {
        var beachNames: [String] = []
        
        if let beachEntities = beachEntities {
            // 检查 beachEntities的值 是否为 BeachEntity 类型：匹配则自动转并绑定到 beach 常量，不匹配则跳过
            for case let beach as BeachEntity in beachEntities {
                beachNames.append(beach.name ?? "N/A")
            }
        }
        
        return beachNames
    }
    
    /// 最后一次更改的时间
    var viewLastUpdated: String {
        return "Last Updated: " +
        (lastUpdated?.formatted(date: .numeric, time: .standard) ?? "N/A")
    }
    
    var viewRatingSum: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return "Total Beach Rating: " + (formatter.string(for: ratingSum) ?? "N/A")
    }
    
    var viewAverageRating: String {
        if beachCount == 0 { // 判空
            return "N/A"
        }
        let averageRating = ratingSum / Double(beachCount) // 获得均值
        // 格式化
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return "Average Beach Rating: " + (formatter.string(for: averageRating) ?? "N/A")
    }
}
