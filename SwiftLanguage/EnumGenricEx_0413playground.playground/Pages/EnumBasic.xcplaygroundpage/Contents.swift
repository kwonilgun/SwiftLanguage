//1월 25일

//‘Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration’s current value, and instance methods to provide functionality related to the values the enumeration represents. Enumerations can also define initializers to provide an initial case value; can be extended to expand their functionality beyond their original implementation; and can conform to protocols to provide standard functionality’


//열거형은 연관된 항목들을 묶어서 표현할 수 있는 타입이다. 열거형은 배열이나 딕셔너리 같은 타입과 다르게
//프로그래머가 정의해준 항목 값 외에는 추가/수정이 불가피하다. 그렇기 때문에 딱 정해진 값만 열거형 값에
//속할 수 있다.



import Foundation


//연관값: associated value, 이넘의 연관값이다.
enum BasicNum {
    case integer(value: Int)       //이것을 연관값이다.
    case double(value: Double)
    case string(value: String)
}

var basic_5: BasicNum = .integer(value: 5)  //연관값 5이다.
var basic_4: BasicNum = .integer(value: 4)  //연관값 4이다.
basic_5 = .double(value: 10.0)
print(basic_5.self)

switch basic_5 {
    case .integer(let x) : print(x)
    case .double(let y) : print(y)
    default: ()
}


// rawValue: 항목의 원시값을 가질 수 있다. 두개의 값이 존재한다. 이넘값과 원시값
enum School : String {      //rawValue를 설정할 수 있다.
    case elemetary = "초등학교"
    case middle = "중학교"
    case highSchool = "고등학교"
    case college = "대학교"
}

let school: School = .elemetary
print(school.rawValue)


//rawValue: 열거형 원시값 정보를 안다면, 원시값을 통해 열거형 변수 또는 상수를 생성해 줄 수 있다.
//항목에 없는 값을 지정하면 nil을 리턴한다. 그럽으로 Optional로 타입을 지정해야 한다.

let mid: School? = School(rawValue: "중학교")
let high = School(rawValue: "고등학교")
print(mid ?? "없음")
print(high ?? "없음")


//연관값:
//스위프트의 열거형 각 항목이 연관 값을 가지게 된다. 열거형 내부의 항목이 자신과 연관된 값을 가질 수 있다. 연관 값은 각
//음식 재료를 마음대로 지정을 할 수 있다.
enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner:MainDish = .pasta(taste: "크림")
dinner = .pizza(dough: "치즈크러스트", topping: "불고기")

print(dinner)

switch dinner {
    case .pizza(dough: let x, topping: let y) : print(x,y)
    default:()
}

//연관값: 식당 재료가 한정적이면 열거형으로 바꾸면 된다.
enum PastaTaste {
    case cream, tomato
}
enum PizzaDough {
    case cheeseCrust, thin, original
}
enum PizzaTopping {
    case pepperoni, cheese, bacon
}
enum MainDishE {
    case pasta(taste: PastaTaste)
    case pizza(dough: PizzaDough, topping: PizzaTopping)
    case chicken(withSource: Bool)
    case rice
}

var dinnerA: MainDishE = .pizza(dough: .cheeseCrust, topping: .bacon)

switch dinnerA {
    case .pizza(dough: let x, topping: let y) : print(x,y)
    default: ()
}


//순환 열거형
//순환열거형은 열거형 항목의 연관 값이 열거형 자신의 값이고자 할 때 사용한다. 특정항목에만 한정하고 싶다면 case 키워드 앞에 indirect를 붙이고, 열거형 전체에 적용하고 싶다면 enum 키워드 앞에 indirect 키워드를 붙이면 된다.

indirect enum ArithmeicExpression {
    case number (Int)
    case addition(ArithmeicExpression, ArithmeicExpression)
    case multiplication(ArithmeicExpression, ArithmeicExpression)
}

let five = ArithmeicExpression.number(5)
let four = ArithmeicExpression.number(4)
let sum = ArithmeicExpression.addition(five, four)
let final = ArithmeicExpression.multiplication(sum, ArithmeicExpression.number(2))

func evaluation(_ expression: ArithmeicExpression) -> Int {
    switch expression {
        case .number(let x) : return x
        case .addition(let left, let right) :
            return evaluation(left) + evaluation(right)
        case .multiplication(let left, let right) :
                return evaluation(left) * evaluation(right)
    }
}

let result: Int = evaluation(final)
print(result)

//비교 가능한 열거형
//Comparable 프로토콜을 준수하는 연관 값만 갖거나 연관값이 없는 열거형은 Comparable 프로토콜을 채택하면 각 케이스를 비교할 수 있습니다.
//CaseIterable 프로토콜은 열거형에 allCases라는 이름의 타입 프로퍼티를 통해 모든 케이스의 컬렉션을 생성해 준다.

enum Condition: Comparable, CaseIterable {
    case terrible, bad, good, great
}

let myCondition: Condition = .good
let yourConition: Condition = .bad

if myCondition >= yourConition {
    print("내 컨디션일 좋다.")
}
else {
    print("너의 컨디션이 좋다. ")
}

let allCases:[Condition] = Condition.allCases    //이넘을 콜렉션 데이터롤 변경해 준다.

for  data in allCases {
    print(data)
}
