//
//  ExtensionTaskEntity.swift
//  ModifyInMOC
//
//  Created by Sanny on 2025/10/24.
//
import SwiftUI

extension TaskEntity {
    var viewDueDate: String {
        dueDate?.formatted(date: .numeric, time: .omitted) ?? ""
    }
    
    var viewPriority: String {
        "\(priority).circle.fill"
    }
    
    var viewTaskName: String {
        taskName ?? "[Enter task name]"
    }
    
    var viewPriorityColor: Color {
        if done == true {
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
