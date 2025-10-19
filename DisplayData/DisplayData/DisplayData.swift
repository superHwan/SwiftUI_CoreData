//
//  DisplayData.swift
//  DisplayData
//
//  Created by Sun on 2025/10/19.
//

import SwiftUI

struct DisplayData: View {
    @FetchRequest(sortDescriptors: []) private var books: FetchedResults<BookEntity>
    
    var body: some View {
        List(books) { book in
            VStack(alignment: .leading, spacing: 12) {
                getImage(imageName: book.cover)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    Text(book.title ?? "")
                        .font(.title2)
                    Spacer()
                    Image(systemName: book.available ? "checkmark" : "xmark")
                }
                
                Text(book.lastUpdated?.formatted(date: .numeric, time: .omitted) ?? "N/A")
                Text("Pages: \(book.pages)")
                Text((book.price ?? 0) as Decimal, format: .currency(code: "USD"))
                Link(destination: book.url ?? URL(string: "https://www.baidu.com")!) {
                    Text("Learn More")
                }
                Text(book.bookId?.uuidString ?? "")
                    .font(.caption2)
            }
            .padding(.vertical)
        }
    }
    
    func getImage(imageName: String?) -> Image {
        if let name = imageName {
            return Image(name)
        } else {
            return Image(systemName: "photo.fill")
        }
    }
}

#Preview {
    DisplayData()
}
