//
//  BookEntity+Extensions.swift
//  Validation
//
//  Created by Sanny on 2025/11/27.
//

extension BookEntity {
    var viewName: String {
        name ?? "[Enter Book Name]"
    }
    
    var viewPublicationDate: String {
        publicationDate?.formatted(date: .numeric, time: .omitted) ?? ""
    }
    
    var viewAuthor: String {
        author ?? "[Enter Author]"
    }
    
    var viewRating: String {
        String(format: "%.1f", rating)
    }
}
