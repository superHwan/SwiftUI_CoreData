//
//  DefaultValueView.swift
//  Validation
//
//  Created by Sanny on 2025/11/27.
//

import SwiftUI
import CoreData

struct DefaultValueView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<BookEntity>(sortDescriptors: [])
    private var books
    
    // 输入相关
    @State private var validationError = ""
    @State private var bookName: String = "" // 接收输入的书名
    @State private var author: String = "" // 接收输入的作者名
    
    var body: some View {
        VStack {
            HeaderView(title: "Optional & Default Value",
                       desc: """
                    Attribute 'name': Not Optional, Without Default Value
                    Attribute 'author': Not Optional, With Default Value "佚名"
                    """,
                       back: .blue,
                       textColor: .white)
            TextField("book name", text: $bookName)
                .textFieldStyle(.roundedBorder)
            TextField("author", text: $author)
                .textFieldStyle(.roundedBorder)
            
            Button("添加") {
                validationError = ""
                let newBook = BookEntity(context: moc)
                if !bookName.isEmpty { // 没有输入值，则不赋值
                    newBook.name = bookName
                }
                if !author.isEmpty { // 没有输入值，则不赋值
                    newBook.author = author
                }
                
                do {
                    try newBook.validateForInsert()
                    try moc.save()
                } catch let e as CocoaError {
                    // 单个CocoaError 的 key-value
//                    let errorDictionary = e.userInfo
//                    print("\(errorDictionary[NSValidationKeyErrorKey] ?? "NSValidationKeyErrorKey")")
//                    print("\(errorDictionary[NSValidationValueErrorKey] ?? "NSValidationValueErrorKey")")
//                    print("\(errorDictionary[NSLocalizedDescriptionKey] ?? "NSLocalizedDescriptionKey")")
//                    print("\(errorDictionary[NSValidationObjectErrorKey] ?? "NSValidationObjectErrorKey")")
                    
                    validationError = e.localizedDescription.firstUppercased
                    moc.undo()
                } catch {
                    validationError = error.localizedDescription.firstUppercased
                    moc.undo()
                }
            }
            .buttonStyle(.borderedProminent)
            
            // 呈现异常信息
            Text(validationError)
                .foregroundStyle(.red)
                .font(.title)
            
            List(books) { book in
                Text("\(book.viewName): \(book.viewAuthor)")
            }
        }
        .onAppear { moc.undoManager = UndoManager() }
        .onDisappear { moc.undoManager = nil }
    }
}

#Preview {
    DefaultValueView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
