//
//  DeletingView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/26.
//
// ForEach + .onDelete(perform:): 呈现 @Published 属性，并执行删除操作
// alert: 显示错误信息，并重置错误状态

import SwiftUI

struct DeletingView: View {
    @StateObject var oo = Singleton_FetchingOO()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(oo.users) { user in
                    Text("\(user.viewFirstName) \(user.viewLastName)")
                }
                .onDelete(perform: oo.delete(offsets:))
            }
            .navigationTitle("Delete")
            .alert("删除失败", isPresented: .constant(oo.deletedError != nil),
                   presenting: oo.deletedError) { _ in
                Button("确定") {
                    oo.deletedError = nil
                }
            } message: { error in
                Text(error.localizedDescription)
            }

        }
        .task {
            oo.fetch()
        }
    }
}

#Preview {
    DeletingView()
}
