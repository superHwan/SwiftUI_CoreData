//
//  FRsView.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/23.
//
// 汇总页面

import SwiftUI

struct FRsView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Custom Property ", destination: CustomPropertyView())
            NavigationLink("NSManagedObjectContext: all records", destination: BuildingWithMocView())
            NavigationLink("NSManagedObjectContext: the required records", destination: MOCDetails())
        }
    }
}
