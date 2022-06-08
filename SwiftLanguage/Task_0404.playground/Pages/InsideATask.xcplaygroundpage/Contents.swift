//: [Previous](@previous)

import Foundation
import SwiftUI

var body: some View {
    Text("Hello, world!")
        .padding()
        .onAppear {
            Task {
                await executeTask()
            }
        }
}

func executeTask() async {
    let basicTask = Task {
        return "This is the result of the task"
    }
    print(await basicTask.value)
}
