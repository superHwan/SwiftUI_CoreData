//
//  String+Extensions.swift
//  DataModelInspector
//
//  Created by Sanny on 2025/11/1.
//

extension StringProtocol {
    /// 首字母大写
    var firstUppercased: String {
        prefix(1).uppercased() + dropFirst()
    }
}
