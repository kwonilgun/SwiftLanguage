//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//‘String interpolation is a way to construct a new String value from a mix of constants, variables, literals, and expressions by including their values inside a string literal. You can use string interpolation in both single-line and multiline string literals. Each item that you insert into the string literal is wrapped in a pair of parentheses, prefixed by a backslash (\)

let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

print(message)
