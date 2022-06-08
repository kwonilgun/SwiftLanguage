//: [Previous](@previous)

import Foundation
import SwiftUI

//iOS 개발을 하다 보면, DispatchQueue.global().async{}류의 코드를 사용할 때가 종종 있다. 이것은 iOS의 비동기 처리 방식이다. GCD라고 한다.
//GCD는 DispatchQueue라는 큐를 관리한다. 그리고 이 큐에는 Serial 큐와 Concurrent 큐가 존재한다. Serial 큐는 작업을 순서대로 하나씩 처리한다. 하나의 작업이 끝날 때까지 다음 작업으로 넘어가지 않는다. Concurrent 큐는 작업을 작업을 여러 스레드에 분산 배치한 후 동시에 처리한다. 대신 작업 완료 순서는 보장되지 않는다.

//Serial 큐나 Concurrent 큐나 모두 다른 스레드로 할 일을 떠넘기는건 같지만, Serial 큐는 하나의 스레드에 차곡차곡 순서대로 쌓는 것이고 Concurrent 큐는 여러 스레드에 마구잡이로 분산 배치 하는 것이라고 보면 이해하기 쉬울 것 같다. Serial 큐는 DispatchQueue.main이고, Concurrent 큐는 DispatchQueue.global()이라고 보면 된다.

//Serial 큐 + sync
//DispatchQueue.main.sync{} 코드다. 하지만 현재 iOS 프로그래밍에선 사용 불가능하다. 데드락을 일으키기 때문이다. 위에서도 설명했듯, sync 메소드는 주어진 작업이 끝날 때까지 다른 작업을 하지 않는다. 즉, 주어진 작업이 완료될 때까지 이전 작업 스레드를 블락하고 기다린다. 메인 스레드에서 sync 메소드를 부르면 메인 스레드가 블락 돼버린다. 그런데 처리해야 할 작업이 메인 스레드에 있으니, 영원히 작업은 실행되지도 않고 끝나지도 않게 되는 것이다. 이러한 데드락을 피하고자 iOS 프로그래밍에선 DispatchQueue.main.sync{}의 사용이 금지되었다.
//Serial 큐 + async
//DispatchQueue.main.async{} 코드다. 메인 스레드로 작업을 순서대로 떠넘기되, 떠넘기기만 할 뿐 완료를 기다리 않는다. 떠넘긴다는 말의 어감이 싫다면 작업을 전달한다고 이해해도 좋다. 중요한 점은 Serial 큐이므로 작업을 하나의 스레드에 순서대로 전달하고, async 메소드이므로 완료를 기다리지 않고 곧 바로 다른 작업을 진행한다는 것이다. 주로 UI 관련 작업을 할 때 사용된다.
//Concurrent 큐 + sync
//DispatchQueue.global().sync{} 코드다. 다른 여러 스레드로 작업을 분산 배치하고, 배치한 작업들이 모두 완료될 때까지 이전 스레드를 블락하고 기다린다. Concurrent 큐니까 작업을 분산 배치하고, sync 메소드이므로 완료를 기다리는 것이다. 사실 별로 자주 보이는 코드는 아니다.
//Concurrent 큐 + async
//DispatchQueue.global().async{} 코드다. 작업을 다른 여러 스레드로 분산 배치하되, 완료를 기다리지 않는다. Concurrent 큐니까 작업을 분산 배치하고, async 메소드이므로 완료를 기다리지 않는다. 주로 API 통신 등을 할 때 사용된다.


print(1)
DispatchQueue.global().sync{
    print(2)
}


//이것은 sync는 작업이 끝날때 까지 기다린다. 
DispatchQueue.global().sync {
    print(3)
    print(40)
}


//작업 완료를 기다리지 않고 Queue에 요청을 하고 그대로 진행을 한다.
DispatchQueue.main.async {
    print(5)
    print(6)
    print(7)
}

print(8)

DispatchQueue.main.async{
    print(9)
}

DispatchQueue.global().sync{
    print(10)
}


//위 소스 코드를 실행 했을 때, 출력되는 순서는 어떻게 될까? 우선 가장 윗 줄에 있는 print(1)이 실행돼서 1이 출력될 것이다.
//그 다음은 DispatchQueue.global().sync{print(2)}가 실행된다. Concurrent 큐와 sync메소드의 조합이다. 작업을 여러 스레드에 분산하되, 완료를 기다린다. 하지만 어차피 print(2) 라는 작업 밖에 없어서 딱히 분산할 것도 없다. 어쨌든 2가 출력된다.
//다음으로 만나게 되는 코드는 DispatchQueue.global().sync{print(3) print(4)}다. 윗 줄과 마찬가지로 Concurrent 큐와 sync 메소드의 조합이다. 작업을 여러 스레드에 분산하는데, 사실 print()문 2개 정도는 분산해서 완료 순서가 보장되지 않는다고 하더라도 그냥 순서대로 나온다. 너무 간단한 작업이기 때문이다. 아무튼, sync 메소드기때문에 작업이 완료될 때까지 다른 작업은 실행되지 않아 3과 4가 출력된다.
//DispatchQueue.main.async{print(5) print(6) print(7)}이 나타났다! Serial 큐이므로 작업을 순서대로 메인 스레드에 전달한다. 하지만 async메소드이므로 전달만 할 뿐, 완료를 기다리지 않는다. 즉, 프로그램의 실행이 이 코드를 지날 때 5, 6, 7은 출력되지 않는다.
//다음 라인으로 내려와 평범하게 print(8)이 작동하여 8이 출력된다.
//DispatchQueue.global().async{print(9)}다. Concurrent 큐이므로 작업을 분산하고, async이므로 완료를 기다리지 않는다. print()문 하나이므로 분산할 것도 없다. 완료를 기다리지 않으므로, 프로그램이 이 코드를 지날 때 9는 출력되지 않는다.
//DispatchQueue.global().sync{print(10)}, 대망의 마지막 줄이다. Concurrent 큐이므로 작업을 분산 배치하고, sync 메소드이므로 작업의 완료를 기다린다. 역시나 print문 하나이므로 분산 배치는 사실 의미가 없고, 작업의 완료를 기다리므로 10이 출력된다.
//여기까지 출력의 결과는 1, 2, 3, 4, 8, 10이다. 이제 남은 5, 6, 7, 9는 어떤 순서로 출력될까? 그것은 알 수 없다. async 메소드로 결과를 기다리지 않고 넘어간 작업이 어떤 순서로 완료되는지는 GCD에 달렸다. 그때그때 상황에따라 다르다는 뜻이다. 단, [5, 6, 7]의 순서는 바뀌지 않는다. 5, 6, 7은 DispatchQueue.main.async{}, 즉 Serial 큐를 사용해서 작업이 순서대로 진행되기 때문이다.
