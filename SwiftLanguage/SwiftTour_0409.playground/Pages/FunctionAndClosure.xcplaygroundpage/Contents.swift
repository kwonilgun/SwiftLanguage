import UIKit

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
if hasAnyMatches(list: numbers, condition: lessThanTen) {
    print("10보다 숫자보다 적은 수가 있다.")
}

func equalSeven(number: Int) -> Bool {
    return number == 7
}

if hasAnyMatches(list: numbers, condition: equalSeven) {
    print("7과 같은 수가 있다.")
}
    
let newArray = numbers.map { (number: Int) -> Int in
    let result = 3 * number
    return result
}
print(newArray)

let doubleArray = numbers.map { $0 * 2 }
print(doubleArray)

let sortedArray = numbers.sorted { $0 > $1 }
print(sortedArray)
