//: [Previous](@previous)

import Foundation

//초기화는 사용할 클래스, 구조 또는 열거형의 인스턴스를 준비하는 과정이다. 이 프로세스에는 해당 인스턴스의 저장된 각 속성에 대한 초기 값을 설정하고 새 인스턴스를 사용하기 전에 필요한 다른 설정이나 초기화를 수행하는 것이 포함됩니다.

//클래스와 구조는 해당 클래스나 구조의 인스턴스가 생성될 때까지 저장된 모든 속성을 적절한 초기 값으로 설정해야 합니다. 저장된 속성은 불확실한 상태로 남겨둘 수 없습니다.

//이니셜라이저 내에 저장된 속성에 대한 초기 값을 설정하거나 속성 정의의 일부로 기본 속성 값을 할당할 수 있습니다. 이러한 작업은 다음 섹션에 설명되어 있습니다.

//초기화 위임
//값 타입에서 이니셜라이저가 다른 이니셜라이저를 호출하려면 self.init을 사용한다.

enum Student {
    case elementary, middle, high
    case none
    
    init() {
        self = .none  // 자신을 초기화한다.
    }
    
    init(koreaAge: Int){    //첫번째 사용자 정의 이니셜라이저
        switch koreaAge {
            case 8...13:
                self = .elementary
            case 14...16:
                self = .middle
            case 17...19:
                self = .high
            default:
                self = .none
        }
    }
    
    init(bornAt: Int, currentYear: Int) {    //두번쨰 사용자 이니셜라이저
        self.init(koreaAge: currentYear - bornAt)
    }
}


var young: Student = Student(koreaAge: 10)
print(young)

young = Student(bornAt: 2000, currentYear: 2018)
print(young)


//실패 가능한 이니셜라이저
//실패 가능한 이니셜라이저는 구조체와 클래스에서도 유용하지만, 특히 열거형에서 유용하게 사용할 수 있다. 특정 case에 맞지 않는 값이 들어오면 생성에 실패할 수 있다.

enum StudentI: String {
    case elementary = "초등학교", middle = "중학교", high = "고등학교"
    
    
//    init() {
//        self = .none  // 자신을 초기화한다.
//    }
    
    init?(koreaAge: Int) {    //첫번째 사용자 정의 이니셜라이저
        switch koreaAge {
            case 8...13:
                self = .elementary
            case 14...16:
                self = .middle
            case 17...19:
                self = .high
            default:
                return nil
        }
    }
    
    init?(bornAt: Int, currentYear: Int) {    //두번쨰 사용자 이니셜라이저
        self.init(koreaAge: currentYear - bornAt)
    }
}

var old: StudentI? = StudentI(koreaAge:50)
print(old ?? "nil" )

old = StudentI(koreaAge: 18)
print(old ?? "nil")
