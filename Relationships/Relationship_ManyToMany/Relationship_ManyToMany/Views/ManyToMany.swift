//
//  ManyToMany.swift
//  Relationships
//
//  Created by Sanny on 2025/11/6.
//
// 所有学生
// 要求：1. 水平样式 组织学生图片 + （名，”Click to see courses for this semester”）；2. 标题：Students

import SwiftUI

struct ManyToMany: View {
    @FetchRequest<StudentEntity>(sortDescriptors: [SortDescriptor(\.name)])
    private var stus
    
    var body: some View {
        NavigationStack {
            List(stus) { student in
                NavigationLink {
                    ClassView(student: student)
                } label: {
                    HStack {
                        Image(uiImage: student.viewImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading) {
                            Text(student.viewName)
                            Text("Click to see courses for this semester.")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Student")
        }
    }
}

#Preview {
    ManyToMany()
        .environment(\.managedObjectContext, CoreDataStack.previewForSchoolDataModel)
}
