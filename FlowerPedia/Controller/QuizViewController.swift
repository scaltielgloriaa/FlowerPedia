//
//  QuizViewController.swift
//  FlowerPedia
//
//  Created by Scaltiel Gloria on 29/04/21.
//

import UIKit
import AVFoundation

class QuizViewController: UIViewController {
    

    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    var player: AVAudioPlayer!
    var quizQuestion = QuizQuestion()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.trueButton.layer.shadowColor = UIColor.black.cgColor
        self.trueButton.layer.shadowOpacity = 0.7
        self.trueButton.layer.shadowOffset = CGSize.zero
        self.trueButton.layer.shadowRadius = 2
        self.falseButton.layer.shadowColor = UIColor.black.cgColor
        self.falseButton.layer.shadowOpacity = 0.7
        self.falseButton.layer.shadowOffset = CGSize.zero
        self.falseButton.layer.shadowRadius = 2
        updateUI()
    }

    @IBAction func answerButton(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let rightAnswer = quizQuestion.checkAnswer(userAnswer: userAnswer)
        if rightAnswer{
            playSound(name: "yes")
        }else{
            playSound(name: "No")
        }
        quizQuestion.nextQuestion()
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    @objc func updateUI() {
        questionImage.image = UIImage(named: quizQuestion.getQuestionImage())
        
        let answerChoices = quizQuestion.getAnswers()
        trueButton.setTitle(answerChoices[0], for: .normal)
        falseButton.setTitle(answerChoices[1], for: .normal)
        
        progressView.progress = quizQuestion.getProgress()
        scoreLabel.text = "Score : \(quizQuestion.getScore())"
    }
    func playSound(name: String) {
       
        let url = Bundle.main.url(forResource: name, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
}
