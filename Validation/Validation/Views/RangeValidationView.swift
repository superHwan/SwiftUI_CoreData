//
//  RangeValidationView.swift
//  Validation
//
//  Created by Sanny on 2025/11/28.
//

import SwiftUI

struct RangeValidationView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<BookEntity>(sortDescriptors: [])
    private var books
    
    // 输入相关
    @State private var validationError = ""
    @State private var bookName: String = "A New Book"
    @State private var rating: Double = 0 // 接收评分
    
    var body: some View {
        VStack {
            HeaderView(title: "Range Validation",
                       desc: """
                    Attribute 'rating':
                    Double
                    Optional, Without Default Value
                    Validation: min[0, 5]max
                    """,
                       back: .blue,
                       textColor: .white)
            TextField("book name", text: $bookName)
                .textFieldStyle(.roundedBorder)
            HStack {
                Text("rating: \(String(format: "%.1f", rating))") // 也可通过 NumberFormatter类型的计算属性实现
                Slider(value: $rating, in: -10...10, step: 0.1)
            }
            
            Button("添加") {
                validationError = ""
                let newBook = BookEntity(context: moc)
                newBook.name = bookName
                newBook.rating = rating // 待验证
                
                do {
                    // 触发验证
//                    try newBook.validateForInsert()
                    try moc.save()
                    
                    bookName = "A New Book"
                } catch {
                    validationError = error.localizedDescription.firstUppercased
                    // 从内存中删除新对象：二选一
                    moc.undo()
//                    moc.delete(newBook)
                }
            }
            .buttonStyle(.borderedProminent)
            
            // 呈现异常信息
            Text(validationError)
                .foregroundStyle(.red)
                .font(.title)
            
            List(books) { book in
                Text("\(book.viewName): \(book.viewRating)")
            }
        }
        .onAppear { moc.undoManager = UndoManager() }
        .onDisappear { moc.undoManager = nil }
    }
}

#Preview {
    RangeValidationView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
