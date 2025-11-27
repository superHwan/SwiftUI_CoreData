//
//  UpdatingView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/27.
//

import SwiftUI

struct UpdatingView: View {
    @StateObject var oo = Singleton_FetchingOO()
    @State private var selectedUser: UserEntity?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(oo.users) { user in
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
                            Text(user.viewFullname)
                            Text("\(user.age)")
                        }
                    }
                    .onTapGesture {
                        selectedUser = user
                    }
                }
            }
            .navigationTitle("Update")
        }
        .task {
            oo.fetch()
        }
        .sheet(item: $selectedUser) { selected in
            UpdateUserView(oo: oo, selectedUser: $selectedUser)
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    UpdatingView()
}
