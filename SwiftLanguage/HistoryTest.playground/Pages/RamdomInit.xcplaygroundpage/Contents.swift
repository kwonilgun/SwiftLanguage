//: [Previous](@previous)

import Foundation

struct Challenge {
    let question: String
    let pronunciation: String
    let answer: String
    var completed: Bool = false
    var succeeded: Bool = false
}

extension Challenge: Hashable {
    func hash(into hasher: inout Hasher) {
        question.hash(into: &hasher)
    }
}

struct ChallengeTest {
    let challenge: Challenge
    let answers: [String]
    func isAnswerCorrect(_ answer: String) -> Bool {
        return challenge.answer == answer
    }
}

//여기서 인스턴스를 만든다.
let challengeTest = ChallengeTest(challenge: Challenge(question: "おねがい　します", pronunciation: "Onegai shimasu", answer: "Please"), answers: ["Thank you", "Hello", "Goodbye"])

//결국 인스턴스 값을 만들어서 ChalleneTest 구조체에 넘겨준다. 
print(challengeTest.challenge)
print(challengeTest.answers)
