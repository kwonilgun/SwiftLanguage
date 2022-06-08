

import Foundation

//열거형의 개별 case는 자동으로 해당 열거형과 동일한 수준의 접근수준을 받습니다.
//개별 열거 case에 대해 다른 접근 수준을 지정 할 수 없습니다.


public enum CompassPoint {
    //private case North : 이렇게 하면 무조건 error라는 것이죠. North는 무조건 public이어야 합니다.
    case North
}

//Raw Values and Associated Values
//열거형 정의의 Raw Value또는 Associated Value값에 사용되는 타입은 열거형 접근 수준 이상의 접근 수준을 가져야합니다. internal 접근 수준이 있는 열거형의 Raw Value타입으로 private를 사용할 수 없습니다.

