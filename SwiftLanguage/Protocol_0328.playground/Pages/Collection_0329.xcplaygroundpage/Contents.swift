
import Foundation

protocol RandomNumberGenerator {
    func random() -> Double
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

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())



protocol DiceGame {
    var dice: Dice { get }
    func play()
}

//class only protocol
protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
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
        
        //print("diceRoll:\(diceRoll)")
        
        delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
        switch square + diceRoll {
        case finalSquare:
            print("finalSquare")
            break gameLoop
        case let newSquare where newSquare > finalSquare:
            print("newSquare:\(newSquare)")
            continue gameLoop
        default:
            square += diceRoll
            square += board[square]
            print("square:\(square)")
        }
    }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker() //권한을 위임한 클래스
let game = SnakesAndLadders()
game.delegate = tracker
//game.play()

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
//print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return " A game of Snakes and Ladders with \(finalSquare) squares"
    }
}

struct Hamster {
    var name: String
    var textualDescription: String {
        return " A hamster named \(name)"
    }
}

//추후 adoptation 선언한다.
extension Hamster: TextRepresentable{}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster

//Collections of Protocol Types
//‘A protocol can be used as the type to be stored in a collection such as an array or a dictionary, as mentioned in Protocols as Types. This example creates an array of TextRepresentable things:

//프로토콜은 콜렉션의 저장되는 타입을 지정할 수 있다. 이렇게 되면 자연스럽게 downcasting이 발생이 된다.

//Note that the thing constant is of type TextRepresentable. It’s not of type Dice, or DiceGame, or Hamster, even if the actual instance behind the scenes is of one of those types. Nonetheless, because it’s of type TextRepresentable, and anything that’s TextRepresentable is known to have a textualDescription property, it’s safe to access thing.textualDescription each time through the loop.’


//💇‍♀️->자연스럽게 downcasting이 발생이 된다. game, d12, simonTheHamster는 각각 타입이 있고. 여기서
let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {
    print(thing.textualDescription)
}
