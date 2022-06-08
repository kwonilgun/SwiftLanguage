import SwiftUI

//‘Result Builders
//A result builder is a type you define that adds syntax for creating nested data, like a list or tree, in a natural, declarative way. The code that uses the result builder can include ordinary Swift syntax, like if and for, to handle conditional or repeated pieces of data.
//The code below defines a few types for drawing on a single line using stars and text.’

//result builder는 자연스럽고, 선언적인 방법으로 중첩 데이터를 생성하는 구문을 추가하는 당신이 정의한 타입이다.

protocol Drawable {
    func draw() -> String
}

struct Line: Drawable {
    var elements: [Drawable]
    func draw() -> String {
        return elements.map { $0.draw() }.joined(separator: "")
    }
}

struct Text: Drawable {
    var content: String
    init(_ content: String) { self.content = content }
    func draw() -> String { return content }
}

struct Space: Drawable {
    func draw() -> String { return " " }
}

struct Stars: Drawable {
    var length: Int
    func draw() -> String { return String(repeating: "*", count: length) }
}

struct AllCaps: Drawable {
    var content: Drawable
    func draw() -> String { return content.draw().uppercased() }
}

let name: String? = "Ravi Patel"

//💇‍♀️->이것이 핵심 부분이다. 결국 [] Array 부분을 @ResultBuilder를 적용하면 선언적인 구문으로 변경을 할 수 있다는 것이 핵심이다.

let manualDrawing = Line(elements: [
    Stars(length: 3),
    Text("Hello"),
    Space(),
    AllCaps(content: Text((name ?? "World") + "!")),
    Stars(length: 2),
    ])
print(manualDrawing.draw())
// Prints "***Hello RAVI PATEL!**’

@resultBuilder
struct DrawingBuilder {
    static func buildBlock(_ components: Drawable...) -> Drawable {
        return Line(elements: components)
    }
    static func buildEither(first: Drawable) -> Drawable {
        return first
    }
    static func buildEither(second: Drawable) -> Drawable {
        return second
    }
}


func draw(@DrawingBuilder content: () -> Drawable) -> Drawable {
    return content()
}

func caps(@DrawingBuilder content: () -> Drawable) -> Drawable {
    return AllCaps(content: content())
}

let something = draw {
    Stars(length: 2)
    Text("Kwon")
}

let drawSome = something.draw()
print(drawSome)

func makeGreeting(for name: String? = nil) -> Drawable {
    
    //💇‍♀️ -> 선언적인 구문으로 변경을 하는 것이다. 이것이 핵심이다.
    let greeting = draw {
        Stars(length: 3)
        Text("Hello")
        Space()
        caps {
            if let name = name {
                Text(name + "!")
            } else {
                
                Text("World!")
            }
        }
        Stars(length: 2)
    }
    return greeting
}
let genericGreeting = makeGreeting()
print(genericGreeting.draw())
// Prints "***Hello WORLD!**"

let personalGreeting = makeGreeting(for: "Ravi Patel")
print(personalGreeting.draw())
// Prints "***Hello RAVI PATEL!**"


