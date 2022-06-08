import UIKit

//Memory Safety

//A conflicting access to memory can occur when different parts of your code are trying to access the same location in memory at the same time’

//동시에 메모리의 같은 위치에 접근을 할 때 메모리 충돌이 발생한다.

//Multiple accesses to a location in memory at the same time can produce unpredictable or inconsistent behavior. In Swift, there are ways to modify a value that span several lines of code, making it possible to attempt to access a value in the middle of its own modification.

// 같은 위치에 동시에 다수 접근은 예측할 수 없고, 일관된 행동 기대할 수 없다.


//‘Overlapping accesses appear primarily in code that uses in-out parameters in functions and methods or mutating methods of a structure. The specific kinds of Swift code that use long-term accesses are discussed in the sections below..

// 장기 접근과 순간 접근 오버래핑은 함수의 in=out 파라미터와 구조체의 mutating method에서 주로 나타난다.


//‘Conflicting Access to In-Out Parameters’


//var stepSize = 1
//func increment(_ number: inout Int) {
//    number += stepSize
//}
//increment(&stepSize)

var stepSize = 1
var copyOfstepSize = stepSize
func increment(_ number: inout Int) {
    number += stepSize
}
increment(&copyOfstepSize)

stepSize = copyOfstepSize

print(stepSize)


func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

struct Player {
    var name: String
    var health: Int
    var energy: Int

    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK’

