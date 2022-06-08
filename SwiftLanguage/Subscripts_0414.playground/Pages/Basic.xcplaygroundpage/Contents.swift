import UIKit

//‘Subscripts
//Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list, or sequence.’
//‘You use subscripts to set and retrieve values by index without needing separate methods for setting and retrieval. For example, you access elements in an Array instance as someArray[index] and elements in a Dictionary instance as someDictionary[key].’

//subscript(index: Int) -> Int {
//    get {
//        // Return an appropriate subscript value here.
//    }
//    set(newValue) {
//        // Perform a suitable setting action here.
//    }
//}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"
