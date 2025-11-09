//
//  ClassView.swift
//  Relationships
//
//  Created by Sanny on 2025/11/6.
//
// 选中学生所拥有的课程
// 要求：1. 一行呈现两门课程；2. ZStack式呈现 课程图 + 名，名字位于图片底部中间；3. 标题：Classes For 学生名

import SwiftUI

struct ClassView: View {
    let student: StudentEntity
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(student.viewClasses) { cl in
                    NavigationLink {
                        StudentInClassView(cl: cl)
                    } label: {
                        Image(uiImage: cl.viewImage)
                            .resizable()
                            .scaledToFit()
                            .overlay(alignment: .bottom) {
                                Text(cl.viewSubject)
                                    .padding(.horizontal, 5)
                                    .foregroundStyle(.black)
                                    .background(Color.white.opacity(0.6))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                }
            }
            .padding(.all, 5)
        }
        .navigationTitle("Class For \(student.viewName)")
    }
}

struct ClassView_Preview: PreviewProvider {
    static var previews: some View {
        let moc = CoreDataStack.singleEntityForPreview
        
        let tuple = SchoolDataInitializer.addSingleMockDataToSchool(moc: moc)
        let stu = tuple.0
        
        return ClassView(student: stu)
            .environment(\.managedObjectContext, moc)
    }
}
