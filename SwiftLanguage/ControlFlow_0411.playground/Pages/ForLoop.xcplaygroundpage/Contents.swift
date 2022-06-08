import UIKit

//Swift provides a variety of control flow statements. These include while loops to perform a task multiple times; if, guard, and switch statements to execute different branches of code based on certain conditions; and statements such as break and continue to transfer the flow of execution to another point in your code.
//Swift also provides a for-in loop that makes it easy to iterate over arrays, dictionaries, ranges, strings, and other sequences.
//Swift’s switch statement is considerably more powerful than its counterpart in many C-like languages. Cases can match many different patterns, including interval matches, tuples, and casts to a specific type. Matched values in a switch case can be bound to temporary constants or variables for use within the case’s body, and complex matching conditions can be expressed with a where clause for each case.’



let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25’

let minutes = 60
for tickMark in 0..<60 {
    print("\(tickMark)", terminator: ",")
}
print("......")
for tickMark in stride(from: 0, to: minutes, by: 5) {
    print("\(tickMark)", terminator: ",")
}
