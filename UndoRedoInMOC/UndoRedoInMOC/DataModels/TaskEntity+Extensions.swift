//
//  TaskEntity+Extensions.swift
//  UndoRedoInMOC
//
//  Created by Sanny on 2025/11/1.
//
// 格式化 TaskEntity 的属性
import SwiftUI

extension TaskEntity {
    var viewDueDate: String {
        dueDate?.formatted(date: .numeric, time: .omitted) ?? ""
    }
    
    var viewName: String {
        name ?? "[Enter Task Name]"
    }
    
    var viewPriority: String {
        "\(priority).circle.fill"
    }
    
    var viewPriorityColor: Color {
        if done {
            return .gray
        }
        // unfinished task
        if priority == 1 {
            return .green
        } else if priority == 2 {
            return .yellow
        } else {
            return .red
        }
    }
}
