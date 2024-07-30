//
//  TriviaResponse.swift
//  Trivia
//
//  Created by Raymond Chen on 7/30/24.
//

import Foundation

struct TriviaResponse: Codable {
    let responseCode: Int
    let results: [TriviaResult]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// MARK: - TriviaResult
struct TriviaResult: Codable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

extension TriviaResult {
    static var mocked: TriviaResult {
        let jsonURL = Bundle.main.url(forResource: "triviaResult", withExtension: ".json")!
        let data = try! Data(contentsOf: jsonURL)
        let triviaResult = try! JSONDecoder().decode(TriviaResult.self, from: data)
        return triviaResult
    }
}

struct TriviaCategoriesResponse: Codable {
    let triviaCategories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case triviaCategories = "trivia_categories"
    }
}

struct Category: Identifiable, Codable {
    let id: Int
    let name: String
}
