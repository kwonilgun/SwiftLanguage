import SwiftUI

//에러 처리 (Error Handling)
//에러 처리 (Error handling) 는 프로그램의 에러 조건에서 응답하고 복구하는 프로세스 입니다. Swift는 런타임에 복구 가능한 에러를 던지고 포착하고 전파하고 조작하기 위한 최고 수준의 지원을 제공합니다.
//일부 작업은 항상 실행을 완료하거나 유용한 출력을 생성한다고 보장되지 않습니다. 옵셔널은 값이 없음을 나타내는데 사용되지만 작업이 실패할 경우 코드가 그에 따라 응답할 수 있도록 에러의 원인을 이해하는 것이 유용한 경우가 많습니다.
//예를 들어 디스크의 파일에서 데이터를 읽고 처리하는 작업을 생각해 봅시다. 지정된 위치에 파일이 존재하지 않거나 파일에 읽기 권한이 없거나 적절한 형식으로 인코딩 되지 않는 것을 포함하여 작업이 실패할 수 있는 많은 방법이 있습니다. 이러한 다른 상황을 구분하면 프로그램에서 일부 에러를 해결하고 해결할 수 없는 에러를 전달할 수 있습니다.

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

//에러 처리 (Handling Errors)
//에러가 발생할 때 주변 코드의 부분이 에러 처리를 담당해야 합니다. 예를 들어 문제를 수정하거나 다른 방법을 시도하거나 사용자에게 에러를 알리는 방법으로 에러를 처리해야 합니다.
//Swift에서는 에러를 처리하는 4가지 방법이 있습니다. 함수에서 해당 함수를 호출하는 코드로 에러를 전파하거나 do-catch 구문을 사용하거나 옵셔널 값으로 에러를 처리하거나 에러가 발생하지 않을 것이라고 주장할 수 있습니다. 각 접근은 아래에 설명되어 있습니다.
//함수에서 에러가 발생하면 프로그램의 흐름이 변경되므로 코드에서 에러가 발생할 수 있는 위치를 신속하게 알 수 있어야 합니다. 코드에서 이러한 위치를 식별하려면 에러가 발생할 수 있는 함수, 메서드, 또는 초기화 구문 호출하는 코드 이전에 try 또는 try? 또는 try! 키워드를 작성합니다. 이 키워드는 아래에 설명되어 있습니다.
//NOTE
//Swift에서 에러 처리는 try, catch 그리고 throw 키워드를 사용하는 다른 언어에서 에러 처리와 유사합니다. Objective-C를 포함하여 많은 언어에서의 예외 처리와 달리 Swift에서 에러 처리는 계산 비용이 많이 드는 프로세스 인 호출 스택 해제가 포함되지 않습니다. 따라서 throw 구문의 성능 특성은 return 구문의 성능 특성과 비슷합니다.

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    
    //여기는 내가 추가를 한 것이다. 여기서 다시 한번 throw 를 던져야 이 함수를 부른 try에서 다시한번 catch를 할 수가 있다.
    do {
        try vendingMachine.vend(itemNamed: snackName)
    } catch VendingMachineError.insufficientFunds(let coins){
        print("코인부족:\(coins)")
        throw VendingMachineError.insufficientFunds(coinsNeeded: 2)
    }
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}



//enum Location {
//    case address(String)
//    case coordinate(Double, Double)
//}
//
//let freddysLocation = Location.address("123 Elm Street")
//let jasonsLocation = Location.coordinate(42.235140, -88.355958)

//print(freddysLocation)

enum Location<T> {
    case address(T)
    case coordinate(T, T)
}

let freddysLocation = Location.address("123 Elm Street")
let jasonsLocation = Location.coordinate(42.235140, -88.355958)
