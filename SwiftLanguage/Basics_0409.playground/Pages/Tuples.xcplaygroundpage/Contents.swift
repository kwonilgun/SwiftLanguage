//: [Previous](@previous)

import Foundation

//‘Tuples group multiple values into a single compound value. The values within a tuple can be of any type and don’t have to be of the same type as each other.’


let http404Error = (404, "Not Found")

//‘You can decompose a tuple’s contents into separate constants or variables, which you then access as usual:’

let (code, message) = http404Error
print("code: \(code)")
print("status: \(message)")

print("code is \(http404Error.0)")


//You can name the individual elements in a tuple
let http200Status = (statusCode: 200, description: "OK")
print("code:\(http200Status.statusCode)")
print("description:\(http200Status.description)")
