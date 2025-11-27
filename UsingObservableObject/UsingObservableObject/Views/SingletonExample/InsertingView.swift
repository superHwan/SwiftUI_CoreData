//
//  InsertingView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/27.
//

import SwiftUI

struct InsertingView: View {
    @StateObject var oo = Singleton_FetchingOO()
    @State private var added = false
    
    var body: some View {
        NavigationView {
            List(oo.users) { user in
                Text(user.viewFullname)
            }
            .navigationTitle("Insert")
            .toolbar {
                Button {
                    added.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .task {
            oo.fetch() // 获取实例数据
        }
        .sheet(isPresented: $added) {
            InsertUserView(oo: oo)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    InsertingView()
}
