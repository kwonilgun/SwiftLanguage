//: [Previous](@previous)

import Foundation

//‘You can use optional chaining with calls to properties, methods, and subscripts that are more than one level deep. This enables you to drill down into subproperties within complex models of interrelated types, and to check whether it’s possible to access properties, methods, and subscripts on those subproperties.’

//옵셔널 체이닝에 대한 모델 클래스 정의 (Defining Model Classes for Optional Chaining)
//하나 이상의 레벨 깊이 인 프로퍼티, 메서드, 그리고 서브 스크립트를 호출하기 위해 옵셔널 체이닝을 사용할 수 있습니다. 타입 호환되는 복잡한 모델 내에서 하위 프로퍼티로 내려갈 수 있으며 해당 하위 프로퍼티에 프로퍼티, 메서드, 그리고 서브 스크립트에 접근 가능한지 확인할 수 있습니다.
//아래의 코드는 여러 레벨 옵셔널 체이닝의 예를 포함하여 몇몇의 후속 예제에서 사용할 4개의 모델 클래스를 정의합니다. 이 클래스는 관련 프로퍼티, 메서드, 그리고 서브 스크립트를 가지는 Room 과 Address 클래스를 추가하여 위의 Person 과 Residence 모델을 확장합니다.
//Person 클래스는 이전과 같게 정의됩니다:
class Person{
    var residence: Residence?
}

class Residence{
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}



let Tom = Person()

if let roomCount = Tom.residence?.numberOfRooms {
    print("Tom's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}




// Prints "Unable to retrieve the number of rooms."
//Tom.residence는 nil 이기 때문에 옵셔널 체이닝은 실패한다.

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
print(Tom.residence ?? "nil")
Tom.residence?.address = someAddress

//dump(someAddress)
//이 예제에서 john.residence 가 nil 이기 때문에 john.residence 에 address 프로퍼티에 설정하기 위한 시도는 실패 할 것입니다.
//이 할당은 = 연산자의 우항의 코드는 평가되지 않으므로 옵셔널 체이닝의 일부입니다. 이전 예제에서 상수에 접근하는 것은 어떠한 영향도 없기 때문에 someAddress 가 평가되지 않는다는 것을 쉽게 파악할 수 없습니다. 아래의 목록은 같은 할당을 수행하지만 주소를 생성하기 위해 함수를 사용합니다. 이 함수는 값을 반환하기 전에 "Function was called"를 출력하여 = 연산자 우항이 평가되었음을 알 수 있습니다.

func createAddress() -> Address {
    print("Function was called.")

    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"

    return someAddress
}

//💇‍♀️🧚‍♀️->Tom.residence가 nil 이기 때문에 createAddress() 가 실행이 되지 않는다.
Tom.residence?.address = createAddress()
//createAddress()가 호출이 되지 않는다.

//residence 가 현재 nil 이므로 서브 스크립트 설정은 실패합니다.
Tom.residence?[0] = Room(name: "Bathroom")
print(Tom.residence ?? "nil")


//rooms 배열에 하나 이상의 Room 인스턴스 가지고 Tom.residence 에 실제 Residence 인스턴스를 생성하고 할당하면 옵셔널 체이닝을 통해 rooms 배열에 항목을 접근하기 위해 Residence 서브 스크립트를 사용할 수 있습니다:

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))


Tom.residence = johnsHouse
//print(Tom.residence ?? "nil")

if let firstRoomName = Tom.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "The first room name is Living Room."


//💇‍♀️->여기서는 "Function was called"가 불려진다. 이것이 핵심이다.
//즉 residence 가 nil 이면 createAddrss() 가 불려지지 않는다.
Tom.residence?.address = createAddress()
print(Tom.residence?.address?.buildingName ?? "없음")
print(Tom.residence?.address?.buildingNumber ?? "nil")

print(Tom.residence?.address?.buildingIdentifier() ?? "nil")
