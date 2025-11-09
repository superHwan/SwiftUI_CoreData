//
//  StudentInClassView.swift
//  Relationships
//
//  Created by Sanny on 2025/11/6.
//
// 当前课程包含的学生
// 要求：1. 学生图片 + 名（HStack 或 Label 实现）；2. 标题：Students In 课程名

import SwiftUI

struct StudentInClassView: View {
    let cl: ClassEntity
    
    var body: some View {
        // 由于不操作 student，故不使用ForEach
        List(cl.viewStudents) { student in
            HStack(alignment: .center) {
                Image(uiImage: student.viewImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(student.viewName)
                    .font(.callout)
            }
        }
        .navigationTitle("Student In \(cl.viewSubject)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StudentInClassView_Preview: PreviewProvider {
    static var previews: some View {
        let moc = CoreDataStack.singleEntityForPreview
        
        let tuple = SchoolDataInitializer.addSingleMockDataToSchool(moc: moc)
        let cl = tuple.1
        
        return StudentInClassView(cl: cl)
            .environment(\.managedObjectContext, moc)

    }
}
