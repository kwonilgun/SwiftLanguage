//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//‘Dictionaries
//A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering. Each value is associated with a unique key, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary don’t have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.’
//‘The type of a Swift dictionary is written in full as Dictionary<Key, Value>, where Key is the type of value that can be used as a dictionary key, and Value is the type of value that the dictionary stores for those keys.’

//‘You can also write the type of a dictionary in shorthand form as [Key: Value]. Although the two forms are functionally identical, the shorthand form is preferred and is used throughout this guide when referring to the type of a dictionary.

//Creting an Empty Dictionary

var namesOfIntegers: [Int: String] = [:]

namesOfIntegers[16] = "sixteen"
print(namesOfIntegers)


//‘Creating a Dictionary with a Dictionary Literal’

//var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports["LHR"] = "London"
print(airports)


airports.updateValue("Dublin Airport", forKey: "DUB")
print(airports)

print(airports["DUB"] ?? "Nil")
if let airportName = airports["DUB"] {
    print(airportName)
}

for (key, value) in airports {
    print("\(key), \(value)")
}

for airportName in airports.values {
    print(airportName)
}
