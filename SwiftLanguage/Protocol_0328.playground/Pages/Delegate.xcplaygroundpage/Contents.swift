//: [Previous](@previous)

//Delegation은 클래스나 struct가 책임의 일부를 다른 type의 인스턴스로 넘겨주거나 위임할 수 있게 하는 디자인 패턴이다. 이 디자인 패턴은 위임된 책임을 캡슐화하는 프로토콜을 정의함으로써 구현되며, conforming type(대표자라고 함)은 위임된 기능을 제공할 수 있도록 보장됩니다. 위임은 특정 액션에 응답하거나 해당 소스의 기본 타입을 알 필요 없이 외부 소스에서 데이터를 획득하는 데 사용할 수 있습니다

//뱀과 사다리 게임 보드 설정은 클래스의 init() 이니셜라이저 내에서 이루어집니다. 모든 게임 로직은 프로토콜의 필수 주사위 속성을 사용하여 주사위 롤 값을 제공하는 프로토콜의 플레이 방법으로 이동합니다.

//게임을 하기 위해 대리자가 필요하지 않기 때문에 대리자 속성은 선택적인 DiceGameDelegate로 정의된다는 점에 유의하십시오. 선택적 유형이기 때문에, 대리자 속성은 자동으로 nil의 초기 값으로 설정됩니다. 그 후, 게임 인스턴스테이터는 속성을 적절한 대리자로 설정할 수 있는 옵션이 있다. DiceGameDelegate 프로토콜은 클래스 전용이기 때문에, 참조 주기를 방지하기 위해 대리자를 약하다고 선언할 수 있습니다.
//
//DiceGameDelegate는 게임의 진행 상황을 추적하는 세 가지 방법을 제공합니다. 이 세 가지 방법은 위의 play() 메소드 내의 게임 논리에 통합되었으며, 새로운 게임이 시작되거나, 새로운 턴이 시작되거나, 게임이 끝날 때 호출됩니다.
//
//대리자 속성은 선택적인 DiceGameDelegate이기 때문에, play() 메서드는 대리자에서 메소드를 호출할 때마다 선택적 체인을 사용합니다. 대리자 속성이 nil이면, 이러한 대리자 호출은 오류 없이 우아하게 실패합니다. Delegate 속성이 nil이 아닌 경우, delegate 메서드는

//The DiceGameDelegate protocol can be adopted to track the progress of a DiceGame. To prevent strong reference cycles, delegates are declared as weak references. For information about weak references, see Strong Reference Cycles Between Class Instances. Marking the protocol as class-only lets the SnakesAndLadders class later in this chapter declare that its delegate must use a weak reference. A class-only protocol is marked by its inheritance from AnyObject, as discussed in Class-Only Protocols.

//프로토콜을 클래스 전용으로 표시하면 이 장의 뒷부분에 있는 SnakesAndLadders 클래스는 대리자가 약한 참조를 사용해야 한다고 선언할 수 있습니다. 클래스 전용 프로토콜은 클래스 전용 프로토콜에서 논의된 바와 같이 AnyObject의 상속으로 표시됩니다.


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

//class only protocol,AnyObject로부터 상속을 받은 클래스 only protocol 이다.
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
game.play()
// Started a new game of Snakes and Ladders
// The game is using a 6-sided dice
// Rolled a 3
// Rolled a 5
// Rolled a 4
// Rolled a 5
// The game lasted for 4 turns’
