//
//  DetailImageView.swift
//  Versioning
//
//  Created by Sanny on 2025/12/3.
//

import SwiftUI

struct DetailImageView: View {
    var parkName: String
    var imageNames: [String]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(imageNames, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .overlay(alignment: .bottom) {
                            Text(parkName)
                                .padding(.horizontal, 5)
                                .foregroundStyle(.black)
                                .background(Color.white.opacity(0.6))
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
        }
    }
}
