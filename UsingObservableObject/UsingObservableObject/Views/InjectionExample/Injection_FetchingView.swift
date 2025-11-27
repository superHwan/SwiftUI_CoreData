//
//  Injection_FetchingView.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/26.
//

import SwiftUI

struct Injection_FetchingView: View {
    @StateObject var oo: Injection_FetchingOO
    
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
            .navigationTitle("Injection")
        }
        .task {
            oo.fetch()
        }
    }
}

struct Injection_FetchingView_Preview: PreviewProvider {
    static var previews: some View {
        let moc = CoreDataStack.shared.managedObjectContext
        
        Injection_FetchingView(oo: Injection_FetchingOO(moc: moc))
    }
}
