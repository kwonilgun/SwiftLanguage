import SwiftUI


//출처: https://zeddios.tistory.com/1218 [ZeddiOS:티스토리]
//객체의 값을 직접 가져오지않고, Key 또는 KeyPath 를 이용해서 간접적으로 데이터를 가져오거나 수정하는 방법
//- key는 String
//- key는 일반적으로 객체에 정의된 accessor method 또는 인스턴스 변수의 "이름"
//- key는 특정 규칙을 따라야함 - ASCII로 인코딩 되고, 소문자로 시작해야하며, 공백이 없어야한다.


struct Address {
    var town: String
}

struct Person {
    var address: Address
}
let address = Address(town: "어쩌구")
let zedd = Person(address: address)

//print(zedd.address)
//print(zedd.address.town)


//keyPath를 이용해서 간접적으로 value를 가져온다.
let zeddAddress = zedd[keyPath: \.address]
print(zeddAddress)  //Address(town: "어쩌구")
let zeddTown = zedd[keyPath: \.address.town]
print(zeddTown)     //어쩌구

let addressTown = address[keyPath: \.town]
print(addressTown)      //어쩌구
