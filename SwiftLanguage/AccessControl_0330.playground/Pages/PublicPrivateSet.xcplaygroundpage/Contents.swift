

import Foundation


//외부 모듈에서 콜한다.
var trackedString = TrackedString()

trackedString.value = "Kwon"

//외부 모듈에서 읽는 것은 괜찮다. public private(set)로 되어 있기 때문이다.
print(trackedString.numberOfEdits)

trackedString.value = "ilgun"

//외부 모듈에서 읽는 것은 괜찮다. public private(set)로 되어 있기 때문이다.
print(trackedString.numberOfEdits)


//이것은 에러가 발생한다. 아무리 public private(set)라고 해도 이미 private(set)가 걸려있기 때문이다. 
//trackedString.numberOfEdits = 3




