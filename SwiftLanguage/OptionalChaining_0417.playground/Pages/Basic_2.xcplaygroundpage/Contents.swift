import UIKit

//옵셔널 체이닝 (Optional Chaining)
//옵셔널 체이닝 (Optional chaining) 은 현재 nil 일 수 있는 옵셔널 인 프로퍼티, 메서드, 그리고 서브 스크립트를 조회하고 호출하기 위한 프로세스 입니다. 옵셔널에 값이 포함되어 있으면 프로퍼티, 메서드, 또는 서브 스크립트는 호출에 성공합니다. 옵셔널이 nil 이면 프로퍼티, 메서드, 또는 서브 스크립트 호출은 nil 을 반환합니다. 여러 조회는 함께 연결될 수 있고 체인에 어느 부분이라도 nil 이면 전체 체인은 실패합니다.
//NOTE
//Swift에서 옵셔널 체이닝은 Objective-C에서 메시징 nil 과 유사하지만 모든 타입에 대해 동작하고 성공 또는 실패 여부를 확인할 수 있습니다.

//옵셔널 체이닝은 nil 값에 대해 호출될 수 있다는 사실을 반영하기 위해 조회하는 프로퍼티, 메서드, 또는 서브 스크립트가 옵셔널 값이 아닌 값을 반환하더라도 항상 옵셔널 값을 반환합니다. 옵셔널 반환 값으로 옵셔널 체이닝 호출이 성공 (반환된 옵셔널 체이닝에 값이 포함됨)했는지 실패 (반환된 옵셔널 값은 nil)했는지 확인할 수 있습니다.
//특히 옵셔널 체이닝 호출의 결과는 예상되는 반환값과 동일한 타입이지만 옵셔널로 래핑됩니다. 일반적으로 Int 로 반환하는 프로퍼티는 옵셔널 체이닝을 통해 접근하면 Int? 를 반환합니다.
//다음의 코드들은 옵셔널 체이닝이 강제 언래핑과 어떻게 다른지 보여주고 성공여부를 확인할 수 있도록 합니다.

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
//새로운 Person 인스턴스를 생성하면 residence 프로퍼티는 옵셔널 규칙에 따라 nil 로 초기화 됩니다. 아래의 코드에서 john 은 nil 의 residence 프로퍼티 값을 가지고 있습니다:
print(john.residence ?? "nil")


//let roomCount = john.residence!.numberOfRooms
// this triggers a runtime error
//John.residence 가 nil 값이 아니고 roomCount 에 방의 적절한 숫자를 포함한 Int 로 설정하면 위의 코드는 정상동작 합니다. 그러나 residence 가 nil 이면 이 코드는 항상 런타임 에러를 트리거 합니다.
//옵셔널 체이닝은 numberOfRooms 의 값에 접근하기 위한 대안으로 제공합니다. 옵셔널 체이닝을 사용하기 위해 느낌표 위치에 물음표를 사용합니다:

print(john.residence?.numberOfRooms)
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."

john.residence = Residence()
print(john.residence?.numberOfRooms)
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

