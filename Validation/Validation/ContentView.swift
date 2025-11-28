//
//  ContentView.swift
//  Validation
//
//  Created by Sanny on 2025/11/27.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("主题：近五年出版的书")
                    .font(.largeTitle)
                
                NavigationLink("Optional & Default Value", destination: DefaultValueView())
                NavigationLink("Number Range Validation", destination: RangeValidationView())
                NavigationLink("Date Range Validation", destination: DateValidationView())
                NavigationLink("Multiple Validation", destination: MultiValidationView())
            }
        }
    }
}

#Preview {
    ContentView()
}
