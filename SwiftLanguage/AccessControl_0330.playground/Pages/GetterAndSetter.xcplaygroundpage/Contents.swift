import Foundation

//Private access는 선언된 영역(enclosing)에서만 요소를 사용할 수 있도록 제한하고, 동일한 파일에 있는 해당 선언의 확장에도 적용됩니다. private 접근은 하나의 선언에서 세부 사항이 사용할때 함수의 특정 부분의 상세 구현을 숨기기 위해 사용합니다.

//private(set)는 값 setter 대해서는 private 이고, getter에 대해서는 internal 이다.
//set(값을 세팅하는 것)만 private으로 하고, 값을 불러오는 get은 internal로 처리할 수 있다.

//상수, 변수, 프로퍼티, 서브스크립트가 private 타입을 사용하는 경우, 상수, 변수, 프로퍼티, 서브스크립트는 반드시 private로 표시되어야 합니다.

//default access levels은 기본 접근 수준은 internal이다. 


//💇‍♀️ -> 값 nuberOfEdits의 변경은 구조체 내부에서만 가능하게 된다. 읽는 것은 외부에서 가능한다. 이렇게하면 변수의 관리를 분리해서 적용을 할 수가 있다.


struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}


var track = TrackedString()
track.value = "Hello"
track.value = "World"
print(track)

//track.numberOfEdits = 5
//
//print(track)

print(track.numberOfEdits)
//track.numberOfEdits = 4  //: 이것은 에러가 발생한다. 결국 set가 private 하기 때문이다. 
