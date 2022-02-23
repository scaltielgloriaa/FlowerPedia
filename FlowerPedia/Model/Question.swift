//
//  Question.swift
//  FlowerPedia
//
//  Created by Scaltiel Gloria on 30/04/21.
//

import Foundation

struct Question {
    let questionImage: String
    let answers: [String]
    let rightAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        questionImage = q
        answers = a
        rightAnswer = correctAnswer
    }
}
