//
//  Singleton_FetchingView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/26.
//

import SwiftUI

struct Singleton_FetchingView: View {
    @StateObject var oo = Singleton_FetchingOO()
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("Singleton")
        }
        .task {
            oo.fetch()
        }
    }
}

#Preview {
    Singleton_FetchingView()
}
