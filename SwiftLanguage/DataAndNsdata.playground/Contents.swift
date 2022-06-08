import UIKit


//Data is a native Swift value type as it is a struct (as mentioned in the documentation). This means that Data implements copy-on-write.
//We can think of Data as an updated version of NSData for Swift, rather than relying on Objective-C code.

//Data는 값 타입의 구조체이다. 여기서 dataStr과 test는 같은 타입이 된다.
//NSData는 참조 타입이고 클래스이다.
// 기본적으로 Data와 NSData는 유사하다. 약간의 메소드가 다를 뿐이다. 새로운 스위프트에서는 Data를 사용하기를 권장한다. 
let str = "Hello World"

let data: Data? = str.data(using: .utf8)
let dataStr: Data = Data(str.utf8)


let stringNS = NSData(data: dataStr)
let test = Data(referencing: stringNS)
dump(test)


//Data and NSData are relatively similar. I mean, yes, some of the methods on each differ. However, you would be well advised to choose (when you have the choice) Data as the newer Swift type which also defines Data as a value type.
//There are some reasons that you might still need to use NSData, and for that you might cast your mind towards Core Data or other Objective-C functions.
