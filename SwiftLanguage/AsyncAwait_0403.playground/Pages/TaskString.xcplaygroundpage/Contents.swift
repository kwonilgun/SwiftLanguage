//: [Previous](@previous)

import Foundation
import SwiftUI

enum ExampleError: Error {
    case somethingIsWrong
    
}




func doSomething() async throws {
    
    //๐โโ๏ธ 2022๋ 6์ 4์ผ: ()->String ์ด ๋ถ๋ถ์ด ์ค์ํ๋ค. ๊ฒฐ๊ตญ ๋ฆฌํดํ๋ ๊ฐ์ ์ง์ ํด์ฃผ๋ ๊ฒ์ด ๋ฌด์๋ณด๋ค ์ค์ํ๋ค. 
    let basicTask = Task(priority: .background) { () -> String in
            // .. perform some work
            
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
            print("3.")
            //throw ExampleError.somethingIsWrong
            return "์คํฐ๋ง์ ๋ฆฌํดํ๋ค. "
        }
        
    //๐โโ๏ธ 2022๋ 6์ 4์ผ -> ์ฌ๊ธฐ๊ฐ ์์ฃผ ์ค์ํ๋ค. Task๋ฅผ ์ธ์คํด์คํํ๋ ๊ฒฝ์ฐ๋ ๋ฐ๋ก ์คํ์ด ๋ค์ด๊ฐ๋ค. ์คํ์ด ๋ค์ด๊ฐ์ ์๊ฐ์ด ๊ฑธ๋ฆฌ๋ ์์์ด ์๋ ๊ฒฝ์ฐ try await basicTask.value ์ด ์คํ ๊ฒฐ๊ณผ๋ฅผ ์ฝ์ด์ค๊ธฐ ์ํด์ await๋ฅผ ํตํด์ ๊ธฐ๋ค๋ฆฌ๊ณ  ์คํ์ด ๋ ๊ฒฐ๊ณผ ๊ฐ์ .value๋ฅผ ํตํด์ ์ฝ์ด์ค๋ ๊ฒฝ์ฐ๊ฐ ๋๋ค.
    
    do {
            print("2.")
            print(try await basicTask.value)
            print(await basicTask.result)
            print("4.")
        } catch {
            print("4. Basic task failed with error: \(error)")
        }
    
}

// 6์ 4์ผ : ์ฌ๊ธฐ์ Task๋ฅผ ๋ง๋ค์ด์ ์คํ์ ํ๋ค. ์ด๊ฒ์ด ์คํ์ด ๋๋ฉด ์ฐ๋ ๋๋ก ์คํ์ด ๋๊ณ  ๋น๋๊ธฐ๋ก ์คํ์ ํ๋ค. ์ฌ๊ธฐ์
Task {
    do{
        print("1.")
        try await doSomething()
        print("5.")
    } catch {
        print(error)
    }
}

