import SwiftUI


/*
 초기화 (Initialization) 는 인스턴스의 클래스, 구조체, 또는 열거형을 사용하기 위해 준비하는 단계입니다. 이 단계에는 인스턴스에 각 저장된 프로퍼티에 초기값을 설정하고 새로운 인스턴스가 사용할 준비가 되지 전에 다른 설정이나 초기화를 수행하는 것을 포함합니다.
 
 특정 타입에 새로운 인스턴스를 생성하기 위해 특수 메서드를 호출하는 것처럼 초기화 구문 (initializers) 을 정의하여 초기화를 구현합니다. Objective-C 초기화 구문과 달리 Swift 초기화 구문은 값을 반환하지 않습니다. 초기화의 주요 역할은 처음 사용되기 전에 타입의 새로운 인스턴스가 올바르게 초기화되는 것을 보장하는 것입니다.
 */
//초기화 동안 프로퍼티 상수 할당 (Assigning Constant Properties During Initialization)

//.....초기화가 완료될 때까지 한정된 값으로 설정되는 한 초기화 중 언제든지 프로퍼티 상수에 값을 할당할 수 있습니다. 프로퍼티 상수에 값이 할당되면 더이상 수정할 수 없습니다.

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// Prints "How about beets?"
beetsQuestion.response = "I also like beets. (But not with cheese.)"


//.....기본 이니셜라이저와 멤버와이즈 이니셜라이저
//사용자 정의 이니셜라이저를 정의해주지 않으면 클래스나 구조체는 모든 프로퍼티에 기본값이 지정이 되어 있다는 전제하에 기본 이니셜라이저를 사용합니다. 기본 이니셜라이저는 저장 프로퍼티의 기본값이 모두 지정되어 있고, 동시에 사용자 정의 이니셔라이저가 정의되어 있지 않은 상태에서 제공됩니다.
//클래스는 멤버 와이즈 초기화를 지원하지 않는다.
struct Point {
    var x: Double
    var y: Double
}

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

//기본 이니셜라이저가 작동한다.
let point: Point = Point(x:1, y:1)
print(point)

//내부에서 프로퍼티에 값이 지정이 되어 있으면 멤버와이즈 각각에 대해서 초기화 가능하다.
let size: Size = Size(height: 10)
print(size)


//.....초기화 위임
//값 타입인 구조체와 열거형은 코드의 중복을 피하기 위해서 이니셜라이저가 다른 이니셜라이저에게 일부 초기화를 위임할 수 있다. 값 타입에서 이니셜라이저가 다른 이니셜라이저를 호출하려면 self.init을 사용합니다. self.init는 이너셜라이저 안에서만 사용할 수 있는 데

enum Student {
    case elementary, middle, high
    case none
    
    init() {
        self = .none  //enum을 객체화한 객체의 초기 값이다.
    }
    
    init(KoreanAge: Int) {
        switch KoreanAge {
        case 8...13:
            self = .elementary
        case 13...16:
            self = .middle
        default:
            self = .none
        }
    }
    
    init(bornAt: Int, currentYear: Int) {
        //이것이 초기화 위임이다. 값 타입에서 다른 init를 콜하는 경우 self.init()를 콜한다.
        self.init(KoreanAge: currentYear - bornAt + 1)
    }
}


var younger: Student = Student(KoreanAge: 10)
print(younger)

younger = Student(bornAt: 2012, currentYear: 2022)
print(younger)

//.....실패 가능한 이니셜라이저
//이니셜라이저를 통해 인스턴스를 초기화할 수 없는 여러가지 예외상황이 있다. 대표적으로 이니셜라이저의 전달인자로 잘못된 값이나 적절히 못한 값이 전달되었을 때, 이니셜라이저는 인스턴스 초기화에 실패할 수 있다. 여러가지 이유로 초기화를 실패하는 경우가 있다. 실패가능한 이니셜라이져 init?


//실패 가능한 이니셜라이저는 구조체와 클래스에서 유용하지만 특히 열거형에서 유용하게 사용할 수 있다. 특정 case에 맞지 않는 값이 들어오면 생성에 실패할 수 있다. 혹은 rawValue로 초기화할 때 잘못된 rawValue가 전달되어 들어온다면 열거형 인스턴스를 생성하지 못할 수 있다. 따라서 rawValue를 통한 이니셜라이저는 기본적으로 실패 가능한 이니셜라이저로 제공된다.

enum StudentEnum : String {
    case elementary = "초등학생"
    case middle = "중학생"
    case high   = "고등학생"
    
    //실패 가능한 이니셜라이저 이다.
    init? (KoreanAge: Int) {
        switch KoreanAge {
        case 8...13:
            self = .elementary
        case 13...16:
            self = .middle
        case 16...19:
            self = .high
        default:
            return nil
        }
    }
    
    init? (bornAt: Int, currentYear: Int) {
        //이것이 초기화 위임이다. 값 타입에서 다른 init를 콜하는 경우 self.init()를 콜한다.
        self.init(KoreanAge: currentYear - bornAt + 1)
    }
}

var grade: StudentEnum? = StudentEnum(KoreanAge: 18 )
if let data = grade { print(data) }
else { print("nil")}


//..... 함수를 사용한 프로퍼티 기본 값 설정
//인스턴스를 초기화할 때 함수나 클로저가 호출되면서 연산 결과값을 프로퍼티 기본값으로 제공한다.

struct StudentFt {
    var name: String?
    var number: Int?
}

class SchoolClass {
    var students: [StudentFt] = {
        var arr: [StudentFt] = [StudentFt]()
        
        for num in 1...15 {
            var student: StudentFt = StudentFt(name: nil, number: num)
            arr.append(student)
        }
        
        return arr
    } ()
}

let myClass: SchoolClass = SchoolClass()
print(myClass.students.count)   //15

//..... 인스턴스 소멸
// 클래스 인스턴스는 디이니셜라이저를 구현할 수 있다. 디이니셜라이저는 이니셜라이즈와 반대이다. 메모리에서 해제되기 전에 클래스 인스턴스와 관련하여 원하는 정리 작업을 구현할 수 있다. 디이니셜라이저는 클래스의 인스턴스에만 구현할 수 있다.

class SomeClass {
    deinit {
        print(" Instancd will be deallocated immediately")
    }
    
    
}

var instance: SomeClass? = SomeClass()
instance = nil

//..... 구조체: 값 타입의 예제

var integer: Int = 100
var integer_1: Int  =  integer

integer_1 = 200

print(integer)
print(integer_1)   //값이 다르다. 결국 구조체는 값 타입니다.


//..... 클래스: 참조 타입 예제
class refInt {
    var int : Int = 0
}

var data_1: refInt = refInt()
var data_2: refInt = data_1

data_1.int = 120
print(data_1.int)
print(data_2.int)   //클래스는 참조 타입이다. 결국 포인터 이다.
