//
//  StringFunctionsView.swift
//  DeriveAttribute
//
//  Created by Sanny on 2025/11/11.
//
// lowercase:(city), uppercase:(city), canonical:(city) 的使用
import SwiftUI

struct StringFunctionsView: View {
    // 按国家名排序的海滩
    @FetchRequest<BeachEntity>(sortDescriptors: [SortDescriptor(\.nationEntity?.name)])
    private var beaches
    
    var body: some View {
        NavigationView {
            List(beaches) { beach in
                VStack(alignment: .leading) {
                    Text(beach.viewName)
                        .font(.title)
                    Text(beach.viewCity)
                    Text(beach.cityUppercase ?? "")
                    Text(beach.cityLowercase ?? "")
                    Text(beach.cityCanonical ?? "")
                }
                .fontWeight(.light)
            }
            .navigationTitle("String Functions")
        }
    }
}

#Preview {
    StringFunctionsView()
        .environment(\.managedObjectContext, CoreDataStack.previewInMemory)
}
