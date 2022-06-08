import UIKit


//2022.5.19 - PropertyList 를 추가하기가 정말 어려웠다. 프로퍼티 리스트는 Playgroud에서 만드는 것이 아니고, iOS APP에서 SwiftUI를 즉 Project를 생성하고 거기에서 New File을 생성하면 탬플릿이 뜨고 ,Resource 밑에 Property List 템플릿이 있다. 

struct Profile: Codable {
    var name: String
    var age : Int
}

enum DataError: Error {
    case UrlError
    
}

func read() throws -> Profile {
    
    //User 프로퍼티 리스트가 있는 곳의 path를 만든다.
    guard let path = Bundle.main.path(forResource: "KwonList", ofType: "plist") else { throw DataError.UrlError }
    
    //path를 URL로 변경한다.
    let url = URL(fileURLWithPath: path)
    
    do {
        //데이타를 읽어오고
        let data = try Data(contentsOf: url)
        
        //이 데이터를 시리얼 테이터를 디코팅한다.
        let profile = try PropertyListDecoder().decode(Profile.self, from: data)
        return profile
    } catch {
        throw error
    }
    

}

do {
    let data = try read()
    print(data)
} catch {
    print(error)
}
