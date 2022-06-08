//: [Previous](@previous)

import Foundation

//‘Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values. Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.’

//‘The type of a Swift array is written in full as Array<Element>, where Element is the type of values the array is allowed to store. You can also write the type of an array in shorthand form as [Element]. Although the two forms are functionally identical, the shorthand form is preferred and is used throughout this guide when referring to the type of an array.’


var someInts: [Int] = []
print("someInts is of type [Int] with \(someInts.count) items")

someInts.append(3)
print(someInts)

//Creating an Array with a Default Value
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)

var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles)

//Creating Array with Array Literal
//var shoppingList: [String] = ["eggs", "milk"]
var shoppingList = ["eggs", "milk"]
shoppingList.append("Flour")
shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
print(shoppingList)

shoppingList[4...6] = ["bannas", "apples"]
print(shoppingList)

for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("\(index + 1) : \(value)")
}
