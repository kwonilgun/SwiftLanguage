import SwiftUI

var dataA: Int = 100
var dataB: Int = 500

func calc(paraA: Int, paraB: Int, task:(Int, Int)->()){

    task(paraA, paraB)
}


//[dataA, dataB]는 데이타를 캡쳐하는 것이고, s1,s2는 파라미터로 처리를 하는 것이다.

calc(paraA: 10, paraB: 20) { [dataA, dataB] s1, s2 in
    print(dataA)
    print(dataB)
    print(s1)
    print(s2)
}

dataA = 10

//획득 목록이 작동을 했다.
//이것이 클로저이다. 클로저에서 작동이 된 것이다. 
var closure = { [dataA]  in
    print(dataA)
    //print(s1)
}
dataA = 500

closure()
