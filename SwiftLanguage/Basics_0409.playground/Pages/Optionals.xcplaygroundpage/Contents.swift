//: [Previous](@previous)

import Foundation

//‘You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)

//convertedNumber is inferred to be of type "Int?", or "optional Int"

print(convertedNumber)

//nil : You set an optional variable to a valueless state by assigning it the special value nil.

var serverResponseCode: Int? = 404
serverResponseCode = nil

//‘If you define an optional variable without providing a default value, the variable is automatically set to nil for you:

var surveyAnswer: String?
//surveyAnswer is automatically set to nil


//If Statements and Forced Unwrapping
//Optional Binding
//You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with if and while statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action.

if let actualNumber = Int(possibleNumber) {
    print("Actual number is \(actualNumber)")
} else {
    print("nil")
}
