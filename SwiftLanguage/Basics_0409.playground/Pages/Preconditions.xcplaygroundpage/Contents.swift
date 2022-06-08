//: [Previous](@previous)

import Foundation

//‘Use a precondition whenever a condition has the potential to be false, but must definitely be true for your code to continue execution. For example, use a precondition to check that a subscript isn’t out of bounds, or to check that a function has been passed a valid value.’
//‘You write a precondition by calling the precondition(_:_:file:line:) [https://developer.apple.com/documentation/swift/1540960-precondition] function. You pass this function an expression that evaluates to true or false and a message to display if the result of the condition is false. For example:’


let index = -1

precondition(index > 0, "Index must be greater than zero.")

print(index)
