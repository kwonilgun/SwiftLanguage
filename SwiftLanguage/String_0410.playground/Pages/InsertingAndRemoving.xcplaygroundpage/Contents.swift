//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//‘o insert a single character into a string at a specified index, use the insert(_:at:) method, and to insert the contents of another string at a specified index, use the insert(contentsOf:at:) method.’

var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
print(welcome)

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))

print(welcome)
