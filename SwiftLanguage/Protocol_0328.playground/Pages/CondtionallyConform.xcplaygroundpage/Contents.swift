//제목: Conditionally Conforming to a Protocol
//A generic type may be able to satisfy the requirements of a protocol only under certain conditions, such as when the type’s generic parameter conforms to the protocol. You can make a generic type conditionally conform to a protocol by listing constraints when extending the type. Write these constraints after the name of the protocol you’re adopting by writing a generic where clause.’

//제네릭 타입은 어떤 조건하에서 프로토콜의 requirement를 만족시킬수 있다. 여기서는 where 절 이후의 Element가 어떤 조건을 만족할 때 Array에게 어떤 Protocol을 준수하라고 할 수 있다.


import Foundation

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

protocol RandomNumberGenerator {
    func random() -> Double
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}



class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}


protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d6  = Dice(sides: 6, generator: LinearCongruentialGenerator())
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
//print(d12.textualDescription)

//Conditionally Conforming to a Protocol


//우선 Array가 TextRepresentable 프로토콜 준수하라고 한다. 조건은  그 엘리먼트도 같은 프로토콜을 준수할 때 이 프로토콜을 준수하라고 한다. 
//💇‍♀️ -> 여기서 Element: TextRepresentable 은 Array의 항목들이 TextRepresentable을 준수해야 한다. d6, d12 가 Elementr가 되는 것이다. 이것이 무엇보다 중요하다.

// 💇‍♀️->이것은 자주 사용되는 프로토콜에 제약을 가하는 방법이다.

//해석을 다시 해 보면 Array가 TextRepresentable을 준수하는 데 그것의 조건이 이것의 속한 개별 엘리먼트 즉 항목이 TextRepresentable  준수하는 경우에만, 준수된다.

extension Array: TextRepresentable where Element: TextRepresentable{
    var textualDescription: String {
            //d6, d12의 textualDescription으로 변환해서 Array를 만들어야 한다.
            let itemsAsText = self.map { $0.textualDescription }
            return "[" + itemsAsText.joined(separator: ", ") + "]"
        }
}


//여기서 Element가 d6, d12이다...


//
let myDice = [d6, d12]

print(myDice.textualDescription)
// Prints "[A 6-sided dice, A 12-sided dice]"
