//
//  AutoEntity+Extensions.swift
//  Relationships
//
//  Created by Sanny on 2025/11/5.
//

extension AutoEntity {
    var viewModel: String {
        model ?? "N/A"
    }
    
    var viewYear: String {
        year ?? "[Not Sure]"
    }
}
