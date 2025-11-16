//
//  ContentView.swift
//  ConCurrency
//
//  Created by Sanny on 2025/11/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                NavigationLink("Concurrency Problems", destination: ModifyInBackgroundClosure())
                NavigationLink("Task: Thread Blocking", destination: Task_ThreadBlockingProblem())
                NavigationLink("Task: no Thread Blocking", destination: Task_NoThreadBlocking())
                NavigationLink("Await Perform", destination: AwaitPerform())
                NavigationLink("Await vs Async", destination: AwaitvsAsync())
                NavigationLink("perform(schedule:_:): return values", destination: Perform_ReturnValues())
                NavigationLink("perform: serial execution", destination: MultiplePerforms())
                NavigationLink("New Background Context", destination: NewBackgroundContext())
                NavigationLink("Background: Auto Merging", destination: BackgroundAutoMerging())
                NavigationLink("Pass Entities By Reference: Wrong", destination: PassEntitiesAround_Wrong())
                NavigationLink("Pass Entities By Reference: Correct", destination: PassEntitiesAround_Correct())
                NavigationLink("Temporary Background", destination: TemporaryBackground())
            }
        }
    }
}

#Preview {
    ContentView()
}
