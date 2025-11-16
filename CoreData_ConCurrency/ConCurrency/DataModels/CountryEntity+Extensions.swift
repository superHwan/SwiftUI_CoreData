//
//  CountryEntity+Extensions.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/10/30.
//
// 处理nil值并格式化

extension CountryEntity {
    var viewCountry: String {
        country ?? "N/A"
    }
    
    var viewCity: String {
        city ?? "N/A"
    }
    
    var viewLastVisited: String {
        lastVisited?.formatted(date: .numeric, time: .omitted) ?? ""
    }
}
