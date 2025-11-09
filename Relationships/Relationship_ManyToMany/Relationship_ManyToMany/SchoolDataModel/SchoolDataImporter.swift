//
//  SchoolDataImporter.swift
//  Relationships
//
//  Created by Sanny on 2025/11/5.
//
// 具体操作：批量导入和关系建立

import CoreData
import UIKit

actor SchoolDataImporter {
    
    /// 批量导入学生数据（可使用字典映射关系）
    static func importStudents(_ students: [(String, StudentImageName)], to moc: NSManagedObjectContext) async -> [StudentEntity] {
        let entities = students.map { (name, imageName) in
            let student = StudentEntity(context: moc)
            student.name = name
            guard let image = UIImage(named: imageName.rawValue), let data = image.pngData() else {
                fatalError("Failed to conver image")
            }
            student.image = data
            return student
        }
        return entities
    }
    
    /// 批量导入课程数据
    static func importClasses(_ classes: [(String, ClassImageName)], to moc: NSManagedObjectContext) async -> [ClassEntity] {
        let entities = classes.map { (name, imageName) in
            let cl = ClassEntity(context: moc)
            cl.subject = name
            // 将图片转为 Binary Data
            guard let image = UIImage(named: imageName.rawValue), let data = image.pngData() else {
                fatalError("Failed to conver image")
            }
            cl.image = data
            return cl
        }
        return entities
    }
    
    // perform<T>(schedule: NSManagedObjectContext.ScheduledTaskType = .immediate, _ block: @escaping () throws -> T) async rethrows -> T
    // 闭包内不抛出异常，可不使用 try
    // MARK: 给学生添加课程关系
    /// 为学生添加课程关系：完全替换现有关系
    static func setClassesToStudent(_ student: StudentEntity, classes: [ClassEntity], to moc: NSManagedObjectContext) async {
        await moc.perform {
            student.classes = NSSet(array: classes)
        }
    }
    
    /// 为学生添加 多个 课程关系：现有关系基础上添加新关系
    static func addClassesToStudent(_ student: StudentEntity, newClasses: [ClassEntity], to moc: NSManagedObjectContext) async {
        await moc.perform {
            // 获取现有课程集合
            let currentClasses = student.classes?.mutableCopy() as? NSMutableSet ?? NSMutableSet()
        
            // 添加新课程
            currentClasses.addObjects(from: newClasses)
        
            // 重新设置关系
            student.classes = currentClasses.copy() as? NSSet
        }
    }
    
    /// 为学生添加 单个 课程关系：现有关系基础上添加新关系
    static func addClassToStudent(_ student: StudentEntity, newClass: ClassEntity, to moc: NSManagedObjectContext) async {
        await moc.perform {
            // 获取现有课程集合
            let currentClasses = student.classes?.mutableCopy() as? NSMutableSet ?? NSMutableSet()
        
            // 添加新课程
            currentClasses.add(newClass)
        
            // 重新设置关系
            student.classes = currentClasses.copy() as? NSSet
        }
    }
    
    // MARK: 为课程添加学生关系
    /// 为课程添加学生关系：完全替换现有关系
    static func setStudentsToClass(_ cl: ClassEntity, students: [StudentEntity], to moc: NSManagedObjectContext) async {
        await moc.perform {
            cl.students = NSSet(array: students)
        }
    }
    
    /// 为课程添加 多个 学生关系：现有关系基础上添加新关系
    static func addStudentsToClass(_ cls: ClassEntity, newStudents: [StudentEntity], to moc: NSManagedObjectContext) async {
        await moc.perform {
            // 获取现有学生集合
            let currentStudents = cls.students?.mutableCopy() as? NSMutableSet ?? NSMutableSet()
        
            // 添加新学生
            currentStudents.addObjects(from: newStudents)
        
            // 重新设置关系
            cls.students = currentStudents.copy() as? NSSet
        }
    }
    
    /// 为课程添加 单个 学生关系：现有关系基础上添加新关系
    static func addStudentToClass(_ cls: ClassEntity, newStudent: StudentEntity, to moc: NSManagedObjectContext) async {
        await moc.perform {
            // 获取现有学生集合
            let currentStudents = cls.students?.mutableCopy() as? NSMutableSet ?? NSMutableSet()
        
            // 添加新学生
            currentStudents.add(newStudent)
        
            // 重新设置关系
            cls.students = currentStudents.copy() as? NSSet
        }
    }
    
    // 由于预览处使用静态计算变量，故不能使用如下代码
//    private let context: NSManagedObjectContext
//    init(context: NSManagedObjectContext) {
//        self.context = context
//    }
}
