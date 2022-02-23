//
//  QuizQuestions.swift
//  FlowerPedia
//
//  Created by Scaltiel Gloria on 30/04/21.
//

import Foundation
import UIKit


class QuizQuestion: UIViewController {
    
    var questionNumber = 0
    var score = 0
    
    let quiz = [
        Question(q: "Rose", a: ["Yes", "No"], correctAnswer: "No"),
        Question(q: "Sunflower", a: ["Yes", "No"], correctAnswer: "Yes"),
        Question(q: "Carnation", a: ["Yes", "No"], correctAnswer: "No"),
        Question(q: "Dahlia", a: ["Yes", "No"], correctAnswer: "No"),
        Question(q: "Lotus", a: ["Yes", "No"], correctAnswer: "Yes"),
        Question(q: "Sakura", a: ["Yes", "No"], correctAnswer: "No"),
        Question(q: "Frangipani", a: ["Yes", "No"], correctAnswer: "No"),
        Question(q: "Orchid", a: ["Yes", "No"], correctAnswer: "Yes"),
        Question(q: "Geranium", a: ["Yes", "No"], correctAnswer: "Yes"),
        Question(q: "Camellia", a: ["Yes", "No"], correctAnswer: "No"),
    ]
    
    func getQuestionImage() -> String {
        return quiz[questionNumber].questionImage
    }
    func getAnswers() -> [String] {
        return quiz[questionNumber].answers
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    
    func getScore() -> Int {
        return score
    }
    
    func nextQuestion() {
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        } else {
            // performSegue(withIdentifier: <#T##String#>, sender: nil)
            questionNumber = 0
            score = 0
        }
    }
    
    func checkAnswer(userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].rightAnswer {
            score += 10
            return true
        } else {
            return false
        }
    }
}
