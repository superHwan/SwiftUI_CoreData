//
//  Books.swift
//  DisplayData
//
//  Created by Sun on 2025/10/19.
//

import CoreData

func addBooks(to bookContainer: BookContainer) {
    // 仅在第一次运行时将数据写入数据库，第一次运行后将 alreadyRun 设为true
    guard UserDefaults.standard.bool(forKey: "alreadyRun") == false else {
        return
    }
    
    UserDefaults.standard.set(true, forKey: "alredayRun")
    
    [
        ("Lakeside", year: 2025, month: 6, day: 25, pages: 300, price: 49.9, available: true, image: "picture1", url: "https://gips0.baidu.com/it/u=2928602311,2508735846&fm=3074&app=3074&f=JPEG"),
        ("Horses under the grasslandide", year: 2024, month: 4, day: 2, pages: 290, price: 29.9, available: false, image: "picture2", url: "https://gips2.baidu.com/it/u=4178618471,1124966383&fm=3074&app=3074&f=JPEG"),
        ("The cattle herd by the lake", year: 2020, month: 10, day: 10, pages: 20, price: 19.9, available: true, image: "picture3", url: "https://gips1.baidu.com/it/u=2603106706,2865388425&fm=3074&app=3074&f=JPEG")
    ]
        .forEach { val in
            bookContainer.insertBook(title: val.0, year: val.year, month: val.month, day: val.day, pages: val.pages, price: val.price, available: val.available, imageString: val.image, urlString: val.url)
        }
}
