import SwiftUI

/*
 DispatchQueue란:
 
 1.작업 항목을 관리하는 클래스이다.
 2.Thread보다 쉽고 효율적으로 코드를 작성할 수 있다. 보통 서버에서 데이터를 받고
    이미지 동영상을 외부에서 다운로드 및 처리할 때  CPU 사용량이 많아 처리를 Main Thread가 아닌 별도의
    Thread에서 처리한 뒤 Main Thread로 결과만을 전달하여 화면에 표시하도록 하여 CPU를 관리할 수
    있다.
 
 3. Main:
    Main Thread에서 처리하는 형태이고 SwiftUI 모든 요소들은 Main Queue에서 수행되어야 한다.
 
 4. Global:
    시스템 전체에 공유되는 concurrent Queue. 병렬적으로 동시에 실행되기는 하지만 QoS를 통해
    우선 순위를 결정할 수 있다. 우선 순위가 높은 작업은 낮은 순위의 작업보다 더 빨리 실행되며, 이를 잘 이용하면 빠르게 실행할 수 있다.
 
 Sync: 작업이 완료된 이후에 Queue에게 컨트롤을 넘긴다.
 
 Async: 작업을 수행할 Queue에게 작업을 넘김과 동시에 현재의 Queue에게 컨트롤을 돌려줍니다. 작업이 끝나기 전까지 기다릴 필요없고 동기와 반대로 Block 상태가 되지 않는다.
 */

/*
 Main Queue : 메인 스레드에서 사용 되는 Serial Queue. 모든 UI 처리는 메인 스레드에서 처리를 해야한다.

 Global Queue : 편의상 사용할 수 있게 만들어 놓은 Concurrent Queue. 처리 우선 순위를 위한 QOS(Quality of Service) 파라미터를 제공한다. 작업 완료의 순서는 정할 수 없지만 우선적으로 일을 처리하게 할 수 있다!

 Custom Queue : GlobalQueue에서 수행되는 임의로 정의한 Queue. Serial & Concurrent 모두 가능하나 보통 Serial 작업 수행. Main과 구분해 사용이 필요할 때 사용


 
 */
/*
 main(serial)
 -> 메인 쓰레드에서 처리되는 Serial Queue 형태로, 우리가 쓰고 있는 UIKit 의 모든 요소들은 Main Queue 에서 수행해야 합니다!!
 앱의 메인 쓰레드에서 task를 처리하는 전역적으로 사용가능한 Serai Queue 형태입니다. 이 메인 큐는 앱의 실행루프와 함께 작동하여 큐에 있는 task 의 실행을 실행 루프에 연결된 다른 이벤트 소스의 실행과 얽힙니다!
  
 간혹 Dispatch Queue를 사용하다가 main.sync를 하면 앱이 죽는 경우를 볼 수 있을텐데,
 
 global (concurrent)
 -> 전체 시스템에서 공유되는 concurrent queue 입니다. 위에서 concurrent queue 는 동시에 진행된다고 했는데, 밑에서 설명할 QoS를 통해서 작업의 우선순위를 결정하게 됩니다
  
 QoS란 ??
 Quality of Service 의 약자로, DispatchQueue에서 수행 할 작업을 분류하기 위해 사용됩니다!
 해당 QoS를 지정해줘서 중요도를 표시하고, 시스템이 우선순위를 정하고 이에따라 스케쥴리을 하게 됩니다~!
  
 우선순위가 높은 작업은 우선순위가 낮은 작업보다 빨리 수행되고,
 잘 설계한다면  조금 더 반응적인 앱을 만들어 낼 수 있습니다!
 */
//Sync 작업

var greeting = "hello IG Kwon"

DispatchQueue.global(qos: .background).sync {
    for item in 1...3 {
        print("sync:\(item)")
    }
}

for item in 1...3 {
    print("After:\(item)")
}


//Async: 동시 처리가 되기 때문에 섞여서 print가 된다.

DispatchQueue.global(qos: .background).async {
    for item in 1...10 {
        print("global(1-10):\(item)")
    }
}

DispatchQueue.global(qos: .background).async {
    for item in 30...40 {
        print("global(30-40):\(item)")
    }
}

for item in 90...100 {
    print("After:\(item)")
}

DispatchQueue.main.async {
    for item in 1...10 {
        print("Async(1-10):\(item)")
    }
}

DispatchQueue.main.async {
    for item in 30...40 {
        print("Async(30-40):\(item)")
    }
}

//for item in 90...100 {
//    print("After:\(item)")
//}
