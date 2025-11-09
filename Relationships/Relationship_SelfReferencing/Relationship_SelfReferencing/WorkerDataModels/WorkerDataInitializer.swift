//
//  WorkerDataInitializer.swift
//  Relationship_SelfReferencing
//
//  Created by Sanny on 2025/11/9.
//

import CoreData

struct WorkerDataInitializer {
    
    static func importWorkerData(to moc: NSManagedObjectContext) async throws {
        guard UserDefaults.standard.bool(forKey: "workerInitAlredayRun") == false else {
            return
        }
        UserDefaults.standard.set(true, forKey: "workerInitAlredayRun")
        
        try await addData(to: moc)
    }
    
    static func addMockDataToWorker(to moc: NSManagedObjectContext) {
        Task {
            do {
                try await addData(to: moc)
            } catch {
                print("Failed to load mock data: \(error.localizedDescription)")
            }
        }
    }
    
    /// 建立关系
    private static func addData(to moc: NSManagedObjectContext) async throws {
        for i in 0..<teams.count {
            let teamEntities = await addWorkers(teams[i], to: moc)
            
            await buildRelationships(teamEntities, to: moc)
        }
        
        try moc.save()
    }
    
    private static func buildRelationships(_ entities: [WorkerEntity], to moc: NSManagedObjectContext) async {
        await moc.perform {
            if entities.count > 1 { // To-Many 端有值
                let newManager = entities[0]
                // relationship: subordinates
                newManager.addToSubordinates(NSSet(array: Array(entities[1..<entities.count])))
                //relationship: manager
                for i in 1..<entities.count {
                    entities[i].manager = newManager
                }
            }
        }
    }
    
    /// 批量导入员工数据
    private static func addWorkers(_ workers: [String], to moc: NSManagedObjectContext) async -> [WorkerEntity] {
        let entities = workers.map { name in
            let newWorker = WorkerEntity(context: moc)
            newWorker.name = name
            return newWorker
        }
        return entities
    }
    
    // 假定每组的首位为 manager
    static let teams: [[String]] = [
        ["Ava", "Noah", "Olivia", "Liam", "Sophia"],
        ["Mason", "Emma", "William"],
        ["Charlotte", "James", "Amelia", "Ethan"],
        ["Fred"]
    ]
}
