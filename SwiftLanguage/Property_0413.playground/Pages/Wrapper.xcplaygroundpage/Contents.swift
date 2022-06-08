//: [Previous](@previous)

import Foundation

//‘A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property.’

//프로퍼티 랩퍼는 프로퍼티가 어떻게 저장되는 지를 관리하는 코드와 프로퍼티를 정의하는 코드 사이에 분리 층을 추가하는 것이다.

// 프로퍼티 값의 정의와 저장 방법을 분리했다. 그리고 이 property wrapper를 여러군데에 적용을 해서 이 관리 코드를 재 사용할 수 있게 한다. 

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

//위의 예에서 number에 대한 선언은 변수를 비공개로 표시하여 number가 TwelveOrLess의 구현에서만 사용되도록 합니다. 다른 곳에 쓰여진 코드는 wrappedValue의 게터와 세터를 사용하여 값에 액세스하며, 숫자를 직접 사용할 수 없습니다. 비공개에 대한 정보는 액세스 제어를 참조하십시오.
//프로퍼티 앞에 속성 래퍼를 적용한다.


struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height) //속성 래퍼가 적용이 되어서 저장할 때 12가 저장이 되고
// Prints "12’

//The name of the projected value is the same as the wrapped value, except it begins with a dollar sign ($). Because your code can’t define properties that start with $, the projected value never interferes with properties you define.
//💇‍♀️ : projected value 이름은 wrapped value와 같다. 이름이 같다. 하지만 앞에 $ 가 붙는다. projected value는 결코 당신이 정의한 프로퍼티를 방해하지 않는다.

@propertyWrapper
struct SmallNumber {
    private var number: Int
    private(set) var projectedValue: Bool

    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }

    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SomeStructure {
    @SmallNumber var someNumber: Int
}

var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false"

someStructure.someNumber = 55
print(someStructure.someNumber)
print(someStructure.$someNumber)
// Prints "true


enum Size {
    case small, large
}

struct SizedRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int

    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 10
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}


var smallSize = SizedRectangle()

print(smallSize.resize(to: .small))
print(smallSize.resize(to: .large))
print(smallSize.height)
print(smallSize.width)


