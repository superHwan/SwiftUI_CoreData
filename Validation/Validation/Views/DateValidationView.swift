//
//  DateValidationView.swift
//  Validation
//
//  Created by Sanny on 2025/11/28.
//

import SwiftUI

struct DateValidationView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<BookEntity>(sortDescriptors: [])
    private var books
    
    // 输入相关
    @State private var validationError = ""
    @State private var bookName: String = "A New Book" // 接收输入的书名
    @State private var date: Date = Date()
    
    var body: some View {
        VStack {
            HeaderView(title: "Range Validation",
                       desc: """
                    Attribute 'publicationDate':
                    Date
                    Optional, Without Default Value
                    Validation: min-2021/1/1, max-2025/12/31
                    """,
                       back: .blue,
                       textColor: .white)
            TextField("book name", text: $bookName)
                .textFieldStyle(.roundedBorder)
            DatePicker("Publication Date", selection: $date, displayedComponents: .date)
            
            Button("添加") {
                let newBook = BookEntity(context: moc)
                newBook.name = bookName
                newBook.publicationDate = date // 待验证
                
                do {
//                    try newBook.validateForInsert()
                    try moc.save()
                } catch let e as CocoaError {
                    let errorDictionary = e.userInfo
                    
                    if let error = (errorDictionary[NSLocalizedDescriptionKey] as? String) {
                        validationError = error.firstUppercased
                    }
                    moc.undo()
                } catch {
                    validationError = error.localizedDescription.firstUppercased
                    moc.undo()
                }
            }
            .buttonStyle(.borderedProminent)
            
            
            List(books) { book in
                Text("\(book.viewName): \(book.viewRating)")
            }
        }
        .onAppear { moc.undoManager = UndoManager() }
        .onDisappear { moc.undoManager = nil }
        .alert("添加失败", isPresented: .constant(validationError.isEmpty == false),
               presenting: validationError) { _ in
            Button("确定") {
                validationError = ""
            }
        } message: { error in
            Text(error) // 呈现异常信息
        }
    }
}

#Preview {
    DateValidationView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
