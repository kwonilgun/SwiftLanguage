import SwiftUI

//Nested Types
//Enumerations are often created to support a specific class or structure’s functionality. Similarly, it can be convenient to define utility classes and structures purely for use within the context of a more complex type. To accomplish this, Swift enables you to define nested types, whereby you nest supporting enumerations, classes, and structures within the definition of the type they support.

//‘To nest a type within another type, write its definition within the outer braces of the type it supports. Types can be nested to as many levels as are required.

// Enum은 특정한 클래스와 구조체 함수를 지원하기 위해서 생성이 된다. 복잡한 타입내에서 사용하기 위해서 그 내에서 정의하는 것이 편할 수 있다. 타입 nesting을 지원한다. 다른 타입 내에서 한 타입을 네스팅하기 위해서,

struct BlackjackCard {
    
    // nested Suit enumeration : 중첩 이넘
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // nested Rank enumeration : 중첩 이넘
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        
        
        //중첩 구조체이다.
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

var theAceOfSpades = BlackjackCard(rank: .ace, suit: .diamonds)
print(theAceOfSpades.description)

theAceOfSpades = BlackjackCard(rank: .queen, suit: .hearts)
print(theAceOfSpades.description)

theAceOfSpades = BlackjackCard(rank: .three, suit: .clubs)
print(theAceOfSpades.description)

//Referring to Nested Types
//To use a nested type outside of its definition context, prefix its name with the name of the type it's nested within:
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print(heartsSymbol)
