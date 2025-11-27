//
//  FP_FetchingView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/26.
//

import SwiftUI

struct FP_FetchingView: View {
    @FetchRequest<UserEntity>(sortDescriptors: [SortDescriptor(\.age)])
    private var users
    @StateObject var oo = FP_FetchingOO()
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            // users 也能正常使用
            List(oo.users) { user in
                HStack {
                    AsyncImage(url: URL(string: user.viewImageURL)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("\(user.viewFirstName) \(user.viewLastName)")
                        Text("\(user.age)")
                    }
                }
            }
            .navigationTitle("Function Parameter")
        }
        .task {
            oo.fetch(by: moc)
        }
    }
}

#Preview {
    FP_FetchingView()
        .environment(\.managedObjectContext, CoreDataStack.shared.managedObjectContext)
}
