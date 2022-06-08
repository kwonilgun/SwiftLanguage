//: [Previous](@previous)

import Foundation



//‘Substrings
//When you get a substring from a string—for example, using a subscript or a method like prefix(_:)—the result is an instance of Substring [https://developer.apple.com/documentation/swift/substring], not another string. Substrings in Swift have most of the same methods as strings, which means you can work with substrings the same way you work with strings. However, unlike strings, you use substrings for only a short amount of time while performing actions on a string.’

let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"

// Convert the result to a String for long-term storage.
let newString = String(beginning)

print(newString)


//‘In the example above, greeting is a string, which means it has a region of memory where the characters that make up the string are stored. Because beginning is a substring of greeting, it reuses the memory that greeting uses. In contrast, newString is a string—when it’s created from the substring, it has its own storage. The figure below shows these relationships:

//‘Both String and Substring conform to the StringProtocol [https://developer.apple.com/documentation/swift/stringprotocol] protocol, which means it’s often convenient for string-manipulation functions to accept a StringProtocol value. You can call such functions with either a String or Substring value.’
