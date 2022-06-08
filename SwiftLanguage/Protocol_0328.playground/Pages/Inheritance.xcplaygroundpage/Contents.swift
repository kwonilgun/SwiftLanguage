//: [Previous](@previous)

import Foundation

//Protocol Inheritance
//A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits. The syntax for protocol inheritance is similar to the syntax for class inheritance, but with the option to list multiple inherited protocols, separated by commas:’

//프로토콜 상속:

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

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
        var board: [Int]
        init() {
            board = Array(repeating: 0, count: finalSquare + 1)
            board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
            board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        }
        weak var delegate: DiceGameDelegate?
        func play() {
            square = 0
            delegate?.gameDidStart(self)
            gameLoop: while square != finalSquare {
                let diceRoll = dice.roll()
                delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
                switch square + diceRoll {
                case finalSquare:
                    break gameLoop
                case let newSquare where newSquare > finalSquare:
                    continue gameLoop
                default:
                    square += diceRoll
                    square += board[square]
                }
            }
            delegate?.gameDidEnd(self)
        }
}

protocol TextRepresentable {
    var textualDescription: String { get }
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

let game = SnakesAndLadders()

//This example defines a new protocol, PrettyTextRepresentable, which inherits from TextRepresentable. Anything that adopts PrettyTextRepresentable must satisfy all of the requirements enforced by TextRepresentable, plus the additional requirements enforced by PrettyTextRepresentable.’

//PrettyTextRepresentable은 TextRepresentable로부터 상속이 된다. 상속되는 것을 모두 만족시키고 자신으로부터 강제되는 조건을 추가로 만족시켜야 한다.

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)
//print(game.textualDescription)
