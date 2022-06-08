import SwiftUI

//Codable / Json Encoding and Decoding

//A type that can convert itself into and out of an external representation."
//자신을 변환하거나 외부표현(external representation)으로 변환할 수 있는 타입입니다.


//출처: https://zeddios.tistory.com/373 [ZeddiOS]
//typealias Codable = Decodable & Encodable
//Codable을 채택했다는 뜻은... Decodable과 Encodable을 둘다 채택한 것과 마찬가지..
//그럼 이제 Codable을 채택한 Person은 어떻게 될까요?
//"A type that can convert itself into and out of an external representation"
//자신을 변환하거나 외부표현(external representation)으로 변환할 수 있는 타입.
//
//외부표현식으로 변환할 수 있다네요. 외부표현식 == JSON이라고 가정했을 때,
//JSON으로 변환 할 수 있다네요 == JSON으로 만들 수 있다네요.
//즉 Person을 JSON으로 어케만드냐?




struct Person: Codable {
    var name: String
    var age: Int
}

//Jason encoder 를 만든다.
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let person = Person(name: "kwon", age: 60)


//jason 형식으로 변경을 해 준다. 특히 .prettyPrinted는 json으로 표현하게 해 준다.
let jsonData = try? encoder.encode(person)

if let jsonData = jsonData, let jsonData = String(data: jsonData, encoding: .utf8) {
    print(jsonData)
}

//if let data = jsonData {
//    if let string = String(data: data, encoding: .utf8){
//        print(string)
//    }
//}

var jsonString: String?

if let data = jsonData {
    jsonString = String(data: data, encoding: .utf8)
}

let decoder = JSONDecoder()
var data = jsonString?.data(using: .utf8)


//저 Person.self가 들어간 자리가 type:의 자리네요.
//이 type은 "Decode할 값의 타입"이에요. 해당 type은 Decodable을 준수해야하구요. 우리가 JSON으로 만들고 싶은 최종적인게 우리의 Person타입이죠? 그래서 Person.self를 넣어준거에요.

print("person type:\(Person.self)")
if let data = data {
    if let jsonMy = try? decoder.decode(Person.self, from: data){
        print(jsonMy)
    }
}

