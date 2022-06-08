import UIKit

//asynchronous (async) functions into Swift, allowing us to run complex asynchronous code almost is if it were synchronous.
//async는 마치 synchronous인것처럼 프로그래밍을 한다.

//This is done in two steps: marking async functions with the new async keyword, then calling them using the await keyword, similar to other languages such as C# and JavaScript.

//Completion handlers are commonly used in Swift code to allow us to send back values after a function returns, but they had tricky syntax as you’ll see.

//completion handler들은 일반적으로 스위프트 코드에서 함수가 리턴된 이후 값들을 다시 돌려주도록 한다.


func fetchWeatherHistory(completion: @escaping ([Double]) -> Void) {
    // Complex networking code here; we'll just send back 100,000 random temperatures
    DispatchQueue.global().async {
        let results = (1...100_000).map { _ in Double.random(in: -10...30) }
        
        //results는 [double] 랜덤한 온도 데이터 100,000개를 생성해서 completion 콜백함수에서 넣어준다.
        completion(results)
    }
}


//이 [doble]를 매개변수로 받아서 평균을 구하고, 구한 평균값을 다시 completion handler에게 입력을 해서 최종 출력을 하게 한다.
func calculateAverageTemperature(for records: [Double], completion: @escaping (Double) -> Void) {
    // Sum our array then divide by the array size
    DispatchQueue.global().async {
        let total = records.reduce(0, +)
        let average = total / Double(records.count)
        completion(average)
    }
}

func upload(result: Double, completion: @escaping (String) -> Void) {
    // More complex networking code; we'll just send back "OK"
    DispatchQueue.global().async {
        //completion("OK")
        completion(String(result))
    }
}


//이것이 completion handler를 nesting 하게 한다.
fetchWeatherHistory { records in
    calculateAverageTemperature(for: records) { average in
        upload(result: average) { response in
            print("Server response: \(response)")
        }
    }
}
