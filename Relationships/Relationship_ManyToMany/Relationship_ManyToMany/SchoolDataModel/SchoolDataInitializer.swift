//
//  SchoolDataInitializer.swift
//  Relationships
//
//  Created by Sanny on 2025/11/6.
//
// 数据初始化，struct-更适用于组织无状态的工具方法

import CoreData
import UIKit

struct SchoolDataInitializer {
    
    /// 导入初始化数据
    static func importSchoolData(to moc: NSManagedObjectContext) async throws {
        guard UserDefaults.standard.bool(forKey: "schoolAlreadyRun") == false else {
            return
        }
        
        UserDefaults.standard.set(true, forKey: "schoolAlreadyRun")
        
        Task {
            try await addSCData(to: moc)
        }
    }
    
    /// 添加一组模拟数据
    static func addMockDataToSchool(moc: NSManagedObjectContext) {
        Task {
            do {
                try await addSCData(to: moc)
            } catch {
                print("Failed to load mock data: \(error.localizedDescription)")
            }
        }
    }
    
    /// 添加单个模拟数据：(StudentEntity, ClassEntity)，用于ClassView 与 StudentInClassView
    static func addSingleMockDataToSchool(moc: NSManagedObjectContext) -> (StudentEntity, ClassEntity) {
        // 由于使用Task并返回对象，会报错Error: Variable 'liam' used before being initialized，不知道怎么处理，就分解写了
        
        let liam = StudentEntity(context: moc)
        liam.name = "Liam"
        guard let image = UIImage(named: "one"), let data = image.pngData() else {
            fatalError("Failed to conver image")
        }
        liam.image = data
        
        let olivia = StudentEntity(context: moc)
        olivia.name = "Olivia"
        guard let image = UIImage(named: "two"), let data = image.pngData() else {
            fatalError("Failed to conver image")
        }
        olivia.image = data
        
        let math = ClassEntity(context: moc)
        math.subject = "大学数学"
        guard let image = UIImage(named: "Mathematics"), let data = image.pngData() else {
            fatalError("Failed to conver image")
        }
        math.image = data
        
        let english = ClassEntity(context: moc)
        english.subject = "通用学术英语"
        guard let image = UIImage(named: "English"), let data = image.pngData() else {
            fatalError("Failed to conver image")
        }
        english.image = data
        
        // 建立关系
        liam.classes = NSSet(array: [math, english])
        math.students = NSSet(array: [liam, olivia])
        
        do {
            try moc.save()
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
        
        return (liam, math)
    }
    
    private static func addSCData(to moc: NSManagedObjectContext) async throws {
        let stus: [(String, StudentImageName)] = [
            ("Liam", .one),
            ("Olivia", .two),
            ("Noah", .three),
            ("Emma", .four),
            ("William", .five),
            ("Sophia", .six),
            ("James", .seven),
            ("Charlotte", .eight),
            ("Benjamin", .nine),
            ("Amelia", .ten)
        ]
        let studentEntities = await SchoolDataImporter.importStudents(stus, to: moc)
        
        let cls: [(String, ClassImageName)] = [
            ("数据分析", .DataAnalysis),
            ("大学数学", .Mathematics),
            ("算法设计与分析", .Algorithm),
            ("通用学术英语", .English),
            ("网球课", .Tennis)
        ]
        let classEntities = await SchoolDataImporter.importClasses(cls, to: moc)
        
        // 此处为了方便，给分成两类课程
        let seriesOne: [ClassEntity] = [classEntities[0], classEntities[1], classEntities[2], classEntities[3]]
        let seriesTwo: [ClassEntity] = [classEntities[0], classEntities[1], classEntities[2], classEntities[4]]
        
        // 为学生添加课程关系
        for i in 0..<stus.count/2 {
            await SchoolDataImporter.setClassesToStudent(studentEntities[i], classes: seriesOne, to: moc)
            await SchoolDataImporter.addStudentsToClass(classEntities[3], newStudents: [studentEntities[i]], to: moc) // 课程添加所属学生
        }
        
        for i in stus.count/2..<stus.count {
            await SchoolDataImporter.setClassesToStudent(studentEntities[i], classes: seriesTwo, to: moc)
            await SchoolDataImporter.addStudentsToClass(classEntities[4], newStudents: [studentEntities[i]], to: moc) // 课程添加所属学生
        }
        
        // 课程添加所属学生
        for i in 0...2 {
            await SchoolDataImporter.setStudentsToClass(classEntities[i], students: studentEntities, to: moc)
        }
        
        try moc.save()
    }
    
    // 由于预览处使用静态计算变量，故不能使用如下代码
//    private let importer: SchoolDataImporter
//
//    init(context: NSManagedObjectContext) {
//        self.importer = SchoolDataImporter(context: context)
//    }
}

enum StudentImageName: String {
    case one, two, three, four, five, six, seven, eight, nine, ten
}

enum ClassImageName: String {
    case DataAnalysis, Mathematics, English, Algorithm, Tennis
//    case DataAnalysis = "数据分析", Mathematics = "大学数学", English = "通用学术英语", Algorithm = "算法设计与分析"
}
