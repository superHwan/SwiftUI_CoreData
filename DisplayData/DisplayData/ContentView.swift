//
//  ContentView.swift
//  DisplayData
//
//  Created by Sun on 2025/10/19.
//
// 对CoreData中 nil 的处理

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<BookEntity>
    
    var body: some View {
        List(books) { book in
            VStack(alignment: .leading, spacing: 12) {
                Image(book.viewCover)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    Text(book.viewTitle)
                        .font(.title2)
                    Spacer()
                    Image(systemName: book.viewAvailable)
                }
                
                Text(book.viewLastUpdated)
                Text(book.viewPages)
                Text(book.viewPrice)
                Link(destination: book.viewURL) {
                    Text("Learn More")
                }
                Text(book.viewBookId)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    ContentView()
}
