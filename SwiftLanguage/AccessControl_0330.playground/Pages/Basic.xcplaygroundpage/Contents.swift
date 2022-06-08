
import Foundation

//public과 open의 경우에는 따로 명시해놓지 않으면 internal로 기본 접근 수준이 정해진다는 소리입니다. 각각 public과 open이 되는 것이 아니라요.


//PublicClass에 있는 init() 모듈이 public으로 선언이 안되어 있기 때문에 에러가 발생을 한다. 
let myPublic = PublicClass()

myPublic.someMethod() 
