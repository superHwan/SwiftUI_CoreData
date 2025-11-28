//
//  MultiValidationView.swift
//  Validation
//
//  Created by Sanny on 2025/11/28.
//

import SwiftUI
import CoreData

struct MultiValidationView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<BookEntity>(sortDescriptors: [])
    private var books
    
    // 输入相关
    @State private var bookName: String = "" // 书名
    @State private var author: String = "" // 作者名
    @State private var rating: Double = -1 // 评分
    @State private var date: Date = Calendar.current.date(from: DateComponents(year: 2015, month: 10, day: 19))! // 出版日期
    // 异常
    @State private var validationError = ""
    
    var body: some View {
        VStack {
            HeaderView(title: "CocoaError",
                       subtitle: "Single / Multiple",
                       desc: """
                    Regarding single / multiple multiple validation error(s).
                    View more details by modifying 'name', 'rating', 'publicationDate'.
                    """,
                       back: .blue,
                       textColor: .white)
            TextField("book name", text: $bookName)
                .textFieldStyle(.roundedBorder)
            TextField("author", text: $author)
                .textFieldStyle(.roundedBorder)
            HStack {
                Text("rating: \(String(format: "%.1f", rating))") // 也可通过 NumberFormatter类型的计算属性实现
                Slider(value: $rating, in: -10...10, step: 0.1)
            }
            DatePicker("Publication Date", selection: $date, displayedComponents: .date)
            
            Button("添加") {
                let newBook = BookEntity(context: moc)
                if !bookName.isEmpty { // 待验证
                    newBook.name = bookName
                }
                if !author.isEmpty { // 没有输入值，则不赋值
                    newBook.author = author
                }
                newBook.rating = rating // 待验证
                newBook.publicationDate = date // 待验证
                
                do {
//                    try newBook.validateForInsert() // 单一验证
                    try moc.save() // 多个验证
                    
                    // 恢复初始状态
                    author = ""
                    rating = -1
                    date = Calendar.current.date(from: DateComponents(year: 2015, month: 10, day: 19))!
                } catch let e as CocoaError {
                    let errorDictionary = e.userInfo
                    
                    // 添加提示信息（可删除）
                    if !errorDictionary.isEmpty {
                        validationError = "For more details, please refer to the console."
                    }
                    
                    for item in errorDictionary {
                        print("Key: \(item.key)")
                        print("Value: \(item.value)")
                        
                        // Multiple Errors (type: Array)
                        if let cocoaErrors = item.value as? [CocoaError] {
                            for error in cocoaErrors {
                                print("------ NSCocoaErrorDomain Code ------")
                                let eDic = error.userInfo
                                for item in eDic {
                                    print("Key: \(item.key)")
                                    print("Value: \(item.value)")
                                }
                            }
                        }
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
        .alert("Invalid Operation", isPresented: .constant(validationError.isEmpty == false),
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
//    MultiValidationView()
//        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
