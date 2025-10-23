//
//  ParksContainer.swift
//  FetchRequest
//
//  Created by Sun on 2025/10/19.
//

import CoreData
import UIKit

@Observable
class ParksContainer {
    private let persistentContainer: NSPersistentContainer
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init() {
        persistentContainer = {
           let container = NSPersistentContainer(name: "ParksDataModel")
            container.loadPersistentStores { description, error in
                if let error = error {
                    print("Failed to load the persistent store:", error.localizedDescription)
                }
            }
            return container
        }()
    }
    
    func save() {
        guard managedObjectContext.hasChanges else { return }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to save the context:", error.localizedDescription)
        }
    }
    
//    func insertPark(name: ParksName, region: String, country: String, rating: Int16, imageName: ParksName) {
//        let park = ParkEntity(context: managedObjectContext)
//        park.name = name.rawValue.replacing("_", with: " ")
//        park.region = region
//        park.country = country
//        park.rating = rating
//        guard let image = UIImage(named: imageName.rawValue), let data = image.jpegData(compressionQuality: 0.8) else {
//            fatalError("Failed to conver image")
//        }
//        park.image = data
//    }
    
    // 通过 PersistentceController 获取自定义的 FetchRequest
    func getFetchRequestByName(_ name: String) -> NSFetchRequest<NSFetchRequestResult>? {
        return persistentContainer.managedObjectModel.fetchRequestTemplate(forName: name)
    }
}
