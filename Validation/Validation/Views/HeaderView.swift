//
//  HeaderView.swift
//  Validation
//
//  Created by Sanny on 2025/11/27.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String?
    let desc: String
    let back: Color
    let textColor: Color
    
    init(title: String, subtitle: String? = nil, desc: String, back: Color, textColor: Color) {
        self.title = title
        self.subtitle = subtitle
        self.desc = desc
        self.back = back
        self.textColor = textColor
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(.largeTitle)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.title2)
                    .foregroundStyle(.gray)
            }
            
            Text(desc)
                .font(.title3)
                .padding([.top, .bottom])
                .frame(maxWidth: .infinity)
                .foregroundStyle(textColor)
                .background(back)
        }
    }
}

#Preview {
    HeaderView(title: "JSON",
               subtitle: "descend",
               desc: "JSON is a JavaScript language way to describe object data. By itself it's not very useful in a SwiftUI app. We want to take that data and put it into either a struct or class.",
               back: .blue,
               textColor: .white)
}
