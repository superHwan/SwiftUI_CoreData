//
//  BookContainer.swift
//  DisplayData
//
//  Created by Sun on 2025/10/19.
//

import CoreData

class BookContainer: ObservableObject {
    let persistentContainer: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: "BooksDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the persistent stores:", error.localizedDescription)
            }
        }
    }
    
    func save() {
        // 检查是否有更改
        guard managedObjectContext.hasChanges else { return }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
    func insertBook(title: String, year: Int, month: Int, day: Int, pages: Int16,
                    price: NSDecimalNumber, available: Bool, imageString: String, urlString: String) {
        let book = BookEntity(context: managedObjectContext)
        book.bookId = UUID()
        book.title = title
        book.lastUpdated = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))
        book.pages = pages
        book.price = price
        book.available = available
        book.cover = imageString
        book.url = URL(string: urlString)
    }
}
