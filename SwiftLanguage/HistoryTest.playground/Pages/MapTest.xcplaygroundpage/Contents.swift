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

class ChallengesViewModel {
    static let challenges: [Challenge] = [
        Challenge(question: "はい", pronunciation: "Hai", answer: "Yes"),
        Challenge(question: "いいえ", pronunciation: "iie", answer: "No"),
        Challenge(question: "おねがい　します", pronunciation: "Onegai shimasu", answer: "Please"),
        Challenge(question: "こんにちわ", pronunciation: "Konnichiwa", answer: "Hello"),
        Challenge(question: "はじめまして", pronunciation: "Hajimemashite", answer: "Nice to meet you"),
        Challenge(question: "もしもし", pronunciation: "Moshi moshi", answer: "Hello"),
        Challenge(question: "すみません", pronunciation: "Sumimasen", answer: "Excuse me"),
        Challenge(question: "ありがとう", pronunciation: "Arigatō", answer: "Thank you"),
        Challenge(question: "ごめんなさい", pronunciation: "Gomennasai", answer: "Sorry")
    ]
    
    var allAnswers: [String] { return Self.challenges.map { $0.answer }}
    var allQuestons: [String] { return Self.challenges.map { $0.question}}
}

let problems = ChallengesViewModel()
let answers = problems.allAnswers
let questions = problems.allQuestons
print(answers)
print(questions)


