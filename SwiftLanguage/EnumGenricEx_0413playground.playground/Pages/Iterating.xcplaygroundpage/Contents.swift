//: [Previous](@previous)

import Foundation

//Iterating over Enumeration Cases
//CaseIterable after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type. Here’s an example:’

enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available’

for beverage in Beverage.allCases {
    print(beverage)
}

//‘The syntax used in the examples above marks the enumeration as conforming to the CaseIterable [https://developer.apple.com/documentation/swift/caseiterable] protocol’

//The compiler can automatically provide an implementation of the CaseIterable requirements for any enumeration without associated values or @available attributes on its cases. The synthesized allCases collection provides the cases in order of their declaration.

//You can take advantage of this compiler support when defining your own custom enumeration by declaring conformance to CaseIterable in the enumeration’s original declaration. The CompassDirection example above demonstrates this automatic implementation.
