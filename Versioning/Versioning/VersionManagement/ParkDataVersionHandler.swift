//
//  ParkDataVersionHandler.swift
//  Versioning
//
//  Created by Sanny on 2025/11/30.
//
import CoreData

protocol ParkDataVersionHandler {
    func getSampleParks() -> [Park]
    func addParkMockData(to moc: NSManagedObjectContext) async throws
}
