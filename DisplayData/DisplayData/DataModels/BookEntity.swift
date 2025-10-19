//
//  BookEntity.swift
//  DisplayData
//
//  Created by Sun on 2025/10/19.
//

import CoreData

// Handle nils and formatting
extension BookEntity {
    var viewCover: String {
        if let cover = cover {
            return cover
        } else {
            return "IMAGENULL"
        }
    }
    
    var viewTitle: String {
        title ?? ""
    }
    
    var viewAvailable: String {
        available ? "checkmark" : "xmark"
    }
    
    var viewLastUpdated: String {
        lastUpdated?.formatted(date: .numeric, time: .omitted) ?? "N/A"
    }
    
    var viewPages: String {
        "Pages: \(pages)"
    }
    
    var viewPrice: String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter.string(from: price ?? 0)!
    }
    
    var viewURL: URL {
        url ?? URL(string: "https://www.baidu.com")!
    }
    
    var viewBookId: String {
        bookId?.uuidString ?? ""
    }
}
