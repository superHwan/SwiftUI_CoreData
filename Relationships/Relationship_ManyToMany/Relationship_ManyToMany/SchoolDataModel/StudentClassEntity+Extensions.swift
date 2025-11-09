//
//  StudentClassEntity+Extensions.swift
//  Relationships
//
//  Created by Sanny on 2025/11/6.
//

import UIKit

extension ClassEntity {
    var viewSubject: String {
        subject ?? "N/A"
    }
    
    // 由于image 为 Binary Data 类型，故使用 UIImage；如果图片数据仅限在 Assets，可用String，传名字即可
    var viewImage: UIImage {
        if let imageData = image, let uiImage = UIImage(data: imageData) {
            return uiImage
        } else {
            return UIImage(systemName: "photo")!
        }
    }
    
    var viewStudents: [StudentEntity] {
        // students?.allObjects 转型为[StudentEntity]，成功则为 Optional([StudentEntity])
        // 空合并运算符?? 解包，Optional([StudentEntity]) 非空则返回解包后结果，否则返回 []
        students?.allObjects as? [StudentEntity] ?? []
    }
}

extension StudentEntity {
    var viewName: String {
        name ?? "N/A"
    }
    
    // 由于image 为 Binary Data 类型，故使用 UIImage；如果图片数据仅限在 Assets，可用String，传名字即可
    var viewImage: UIImage {
        if let imageData = image, let uiImage = UIImage(data: imageData) {
            return uiImage
        } else {
            return UIImage(systemName: "photo")!
        }
    }
    
    var viewClasses: [ClassEntity] {
        classes?.allObjects as? [ClassEntity] ?? []
    }
}
