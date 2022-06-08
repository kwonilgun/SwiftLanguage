import  Foundation

//UserDefaults는 App 시작시 사용자의 기본 데이터베이스를 키-값 쌍으로 지속적으로 저장하는 인터페이스이다. 런타임 시 개체를 사용하여 App이 사용자의 기본 데이터베이스에서 사용하는 기본값을 읽기 때문에 값이 필요할 때마다 데이터베이스를 열 필요가 없어진다.


//UserDefaults.standard
//공유된 기본값 객체를 반환하는 계산된 프로퍼티이다. .


//하나의 객체를 얻어온다. shared default object
print(UserDefaults.standard)


//set(Any?, forKey: String)
//set 명령어를 통해 UserDefaults 데이터베이스에 등록을 할 수 있다. 기본적인 형식이 Dictionary 구조이기 때문에 앞쪽에 value값을 넣고 forKey에는 key값을 지정해야한다. 데이터가 존재하는지 확인하기 위해서는 해당 값의 형식에 따라 object, url, array, dictionary, string, stringArray, data, bool, integer, float, double 등을 호출하고 해당 값의 키를 forKey 파라미터에 입력을 하면 된다. value값이 String인 경우 값이 없을 수도 있는 경우가 있기 때문에 해당 값들을 사용할려면 ??나 guard 문을 사용하여 없을 때를 대비하는 것이 좋다. 기존의 사용하던 key의 value값을 바꿀 때도 set을 통해 똑같은 key값을 입력하면 변경이 가능하다.

UserDefaults.standard.set("박선미", forKey: "name")
UserDefaults.standard.set(58, forKey: "age")
//dump(UserDefaults.standard)
print(UserDefaults.standard.string(forKey: "name") ?? "nil")
