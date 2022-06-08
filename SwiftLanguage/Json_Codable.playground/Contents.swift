import UIKit

// Codable: A type that can convert itself into and out of an external representation
// external representation은 jason 이라고 생각하면 된다.

//typealias Codable = Decodable & Encodable

//Encoding and Decoding Custom Types



//💇‍♀️ -> 이것은 Codable 프로토콜을 준수하기 때문에 encoder, decoder를 사용할 수가 있다.


//Codable을 채택했다는 뜻은... Decodable과 Encodable을 둘다 채택한 것과 마찬가지..
//그럼 이제 Codable을 채택한 Person은 어떻게 될까요?
//"A type that can convert itself into and out of an external representation"
//자신을 변환하거나 외부표현(external representation)으로 변환할 수 있는 타입.

struct Person: Codable {
    var name: String
    var age: Int
}

//여러가지 encoder 중에서 Jason encoder를 사용할 수 있다.
//An object that encodes instances of a data type as JSON objects.
let encoder = JSONEncoder()

encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

let person = Person(name: "권일근", age: 61)
let jsonData = try? encoder.encode(person)

var jsonExternal: String = ""

if let jsonData = jsonData, let jsonString = String(data: jsonData, encoding: .utf8) {
    jsonExternal = jsonString
    print(jsonString)
}


let decoder = JSONDecoder()

var data = jsonExternal.data(using: .utf8)

if let data = data, let myPerson = try? decoder.decode(Person.self, from: data) {
    print(myPerson.name)
    print(myPerson.age)
}


//저 Person.self가 들어간 자리가 type:의 자리네요.
//이 type은 "Decode할 값의 타입"이에요. 해당 type은 Decodable을 준수해야하구요. 우리가 JSON으로 만들고 싶은 최종적인게 우리의 Person타입이죠? 그래서 Person.self를 넣어준거에요.
//우리 맨날 어떻게 했어요...


//var person = Person()
//
//if let personDictionary = response  {
//    person.name = personDictionary["name"] as? String
//    person.age = personDictionary["age"] as? String
//}
//
//jsonserialization써서 Foundation객체로 만들고..Dictionary로 해서..해당 Key값 불러와서 내 인스턴스 프로퍼티에 대입하고..이랬죠??이랬던 과정을!!!!!!
//


