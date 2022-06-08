//‘Strong Reference Cycles for Closures’


import Foundation
import CoreFoundation


//‘A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure’s body accesses a property of the instance, such as self.someProperty, or because the closure calls a method on the instance, such as self.someMethod(). In either case, these accesses cause the closure to “capture” self, creating a strong reference cycle.

//클러저를 클래스 인스턴스의 프로퍼티에 저장할 때 강한 참조가 발생한다. 클로저의 바디는 인스턴스를 획득한다. 바디 내에 인스턴스와 메소드에 접근을 하기 위해서 self 인스턴스를 캡쳐한다. 강한 참조발생한다.

class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = { [weak self] in
        if let text = self?.text {
            return "<\(self?.name ?? "")>\(text)</\(self?.name ?? "")>"
        } else {
            return "<\(self?.name ?? "")) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

var  heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// Prints "<h1>some default text</h1>

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>’

paragraph = nil

