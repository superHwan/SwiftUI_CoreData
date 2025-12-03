//
//  Park.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//

struct Park {
    var name: String
    var region: String
    var country: String
    var image: String // 图片：无后缀文件名
    var rating: Int? // Version 2+
    var detailImages: Array<String>? // Version 3
}
