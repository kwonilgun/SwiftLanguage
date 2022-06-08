
import Foundation

/*
 Result Type

 이제 새롭게 도입된 Result에 대해 알아보도록 하겠습니다.
 Result는 Generic Enumeration으로 선언되어 있습니다.
  
 public enum Result<Success, Failure> where Failure : Error
  
 💇‍♀️제네릭으로 선언되었다는 것은 형식이 명확하다는 것을 의미합니다. 형식에 관한 모호함이 사라지게 되는 것이죠. Result는 성공과 실패 2가지가 존재합니다. Success에는 작업의 결과가 저장되고 Failure에는 에러가 저장됩니다.

 예를 들어, 서버에서 JSON 데이터를 받아온다고 하면 성공할 경우 Success에 해당 데이터를 담아주게 됩니다.
 Result Type은 완전히 새로운 개념은 아닙니다. Alamofire와 같은 라이브러리에서는 이미 직접 구현한 Result Type을 활용하고 있습니다. 이제는 Swift에서 직접 제공하기 때문에 라이브러리 의존성을 줄일 수 있게 되었습니다.
 */

/*
 작업이 성공하면 Int가 리턴되고 실패하면 NumberError가 리턴되는 것을 명확히 알 수 있도록 함수의 리턴 형식이 변경되었습니다. 에러 형식을 직접 선언하기 때문에 형식 안정성이 보장되었습니다. 이제는 잘못된 형식으로 인해 발생하는 문제는 컴파일 단계에서 확인되어집니다.
 에러를 처리하는 시점이 함수를 호출하는 시점에서 작업 결과를 사용하는 시점으로 이동한 것을 알 수 있습니다. 이것을 Delayed Error Handling 이라고 부릅니다.
 */

enum NumberError: Error {
   case negativeNumber
   case evenNumber
}

//결과적으로 홀수이면 .success에 Int가 저장이되고, 짝수 이면 .failure에 해당되는 Error enum이 연관값이 저장이 된다. 
func isOddNumber(number: Int) -> Result<Int, NumberError> {
   guard number >= 0 else {
      return Result.failure(NumberError.negativeNumber)
   }

   guard !number.isMultiple(of: 2) else {
      return .failure(.evenNumber) // 형식 추론이 가능하므로 간단하게 작성 가능
   }

   return .success(number)
}



func printResult(result: Result<Int, NumberError>){
    switch result {
    case .success(let data):
        print("성공 = \(data)")
    case .failure(let error):
        //print("에"error.hashValue)
        print("에러 = \(error)")
    }
}

let result: Result<Int, NumberError> = isOddNumber(number: 3)
print(type(of: result))
printResult(result: result)

let count = isOddNumber(number: 2)
printResult(result: count)

let minus = isOddNumber(number: -1)
printResult(result: minus)



//if let successResult = try? result.get() {
//    print(successResult)
//}
//
//let count = isOddNumber(number: 2)
//


