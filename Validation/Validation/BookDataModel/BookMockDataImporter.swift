//
//  BookMockDataImporter.swift
//  Validation
//
//  Created by Sanny on 2025/11/27.
//
import Foundation
import CoreData

struct BookMockDataImporter {
    func addMockData(to moc: NSManagedObjectContext) async throws {
        try await moc.perform {
            // 遍历添加数据
            for book in sampleBooks {
                let bookEntity = BookEntity(context: moc)
                bookEntity.name = book.name
                bookEntity.author = book.author
                bookEntity.rating = book.rating
                bookEntity.publicationDate = book.publicationDate
            }
            
            try moc.save()
        }
    }
    
    private let sampleBooks = [
        Book(
            name: "明天我要去冰岛",
            author: "嘉倩",
            rating: 4.5,
            publicationDate: Date(timeIntervalSince1970: 1640995200) // 2022-01-01
        ),
        Book(
            name: "星辰与尘",
            author: "刘慈欣",
            rating: 4.8,
            publicationDate: Date(timeIntervalSince1970: 1609459200) // 2021-01-01
        ),
        Book(
            name: "编程之美",
            author: "图灵出版社",
            rating: 4.2,
            publicationDate: Date(timeIntervalSince1970: 1672531200) // 2023-01-01
        ),
        Book(
            name: "AI时代的思考",
            author: "李开复",
            rating: 4.6,
            publicationDate: Date(timeIntervalSince1970: 1643673600) // 2022-02-01
        ),
        Book(
            name: "Swift编程入门",
            author: "Apple Inc.",
            rating: 4.4,
            publicationDate: Date(timeIntervalSince1970: 1593561600) // 2020-07-01
        ),
        Book(
            name: "数据可视化艺术",
            author: "陈为",
            rating: 4.7,
            publicationDate: Date(timeIntervalSince1970: 1704067200) // 2024-01-01
        ),
        Book(
            name: "元宇宙入门",
            author: "马化腾",
            rating: 4.3,
            publicationDate: Date(timeIntervalSince1970: 1711929600) // 2024-04-01
        ),
        Book(
            name: "量子计算简史",
            author: "郭光灿",
            rating: 4.9,
            publicationDate: Date(timeIntervalSince1970: 1735689600) // 2025-01-01
        )
    ]
}
