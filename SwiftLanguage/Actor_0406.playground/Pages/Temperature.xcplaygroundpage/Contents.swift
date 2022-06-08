

import Foundation
import SwiftUI

//‘Actors
//Like classes, actors are reference types, so the comparison of value types and reference types in Classes Are Reference Types applies to actors as well as classes. Unlike classes, actors allow only one task to access their mutable state at a time, which makes it safe for code in multiple tasks to interact with the same instance of an actor. For example, here’s an actor that records temperatures:’

//클래스처럼, actor도 reference type이다. 클래스와 달리 액터는 단지 하나의 타스크가 한번에 mutable state를 접근하게 한다. 즉 다수의 타스크가 액터의 같은
//인스턴스를 다수의 타스크에서 안전하게 접근을 할 수 있도록 한다.


//max 프로퍼티는 단지 액터 코드 내에서만 값을 업데이트할 수 있다.

//logger.max에 접근은 가능한 중단 포인트가 된다. 액터가 단지 한 타스크가 한번에 mutable state에 접근을 허용하기 때문에, 다른 타스크의 코드가 이미 logger와 인터랙션을 하고 있다면, 그것이 그 프로퍼티를 접근하는 동안은 코드는 중지가 된다.
//하지만 액터 내부의 코드는 액터의 프로퍼티에 접근을 할 때는 await를 적용하지 않는다.  update는 이미 actor위에 돌고 있기 때문에, max 앞에 await를 할 필요가 없다. 어떤 actor의 상태는 invariants를 깰 수가 있다. 새로운 측정값을 기록을 할 때, 그것은 최고 값을 업데이트한다. 측정값을 append하고, 이 값을 max 값으로 업데이트하기 전에 즉 중간 상태에서 다른 타스크에서 max 값을 읽을 수가 있다. 이렇게 되면 잘못된 값을 읽을 수가 있다.
//액터는 이와같은 문제를 방지할 수가 있다. 컴파일러 단계에서

//‘Accessing logger.max without writing await fails because the properties of an actor are part of that actor’s isolated local state. Swift guarantees that only code inside an actor can access the actor’s local state. This guarantee is known as actor isolation.’
//액터 고립

actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}



func runTask() {
    Task{
        let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
        await print( logger.max)
        // Prints "25’
    }
}

runTask()


//‘Your code calls the update(with:) method. It updates the measurements array first.
//Before your code can update max, code elsewhere reads the maximum value and the array of temperatures.
//Your code finishes its update by changing max.
//
//In this case, the code running elsewhere would read incorrect information because its access to the actor was interleaved in the middle of the call to update(with:) while the data was temporarily invalid. You can prevent this problem when using Swift actors because they only allow one operation on their state at a time, and because that code can be interrupted only in places where await marks a suspension point. Because update(with:) doesn’t contain any suspension points, no other code can access the data in the middle of an update.’


//위의 경우 다른 곳에서 돌아가는 코드가 부정확한 정보를 읽을 수 있다. 데이타를 업데이트 하기 전에 임시적으로 유효하지 않다. 이것을 방지하기 위해서 actor를 사요한다. 한번에 한개의 오퍼레이션만 허용을 한다. 이 코드는 단지 await에 의해서만 중지할 수 있지만 여기서는 중지 포인터가 없ㅅ다. 업데이트 도중에는 다른 코드가 데이터에 접근을 할 수 없다.

//actor 외부로 부터 이런 프로퍼티에 접근을 하기 위해서는 await를 print( await logger.max) 처럼 await를 사용해야 한다.
