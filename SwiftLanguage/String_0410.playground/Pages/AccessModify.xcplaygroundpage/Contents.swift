//: [Previous](@previous)

import Foundation

//‘As mentioned above, different characters can require different amounts of memory to store, so in order to determine which Character is at a particular position, you must iterate over each Unicode scalar from the start or end of that String. For this reason, Swift strings can’t be indexed by integer values.


//string은 integer 값으로 인덱스 되지 않는다.

let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a’

print(greeting[greeting.startIndex])
print(greeting[greeting.index(before: greeting.endIndex)])

for index in greeting.indices {
    //print("\(index)")
    print("\(greeting[index])", terminator:":")
}
