//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // Game variables
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var timer: Timer!
    let timeInterval: TimeInterval = 1
    
    
    // Sounds
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 1
    var incorrectSound: SystemSoundID = 2
    var timeCount = 15
    
    
    
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var questionField: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var nextQuestion: UIButton!
    
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadGameStartSound()
        
        // Start game
        shuffle()
        playGameStartSound()
        displayQuestion()
        answer1Button.layer.cornerRadius = 15
        answer2Button.layer.cornerRadius = 15
        answer3Button.layer.cornerRadius = 15
        answer4Button.layer.cornerRadius = 15
        nextQuestion.layer.cornerRadius = 15
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func endTimer(timer:Timer) {
        if(timeCount <= 0) {
            timer.invalidate()
            timerLabel.isHidden = true
            questionField.text = "Time Up!"
        
            let selectedQuestion = questions[indexOfSelectedQuestion]
            answerLabel.isHidden = false
            answerLabel.text = "The correct answer is \(selectedQuestion.answers[selectedQuestion.answerIndex])"
            nextQuestion.isHidden = false
        }else {
            timerLabel.text = String(timeCount)
            timeCount -= 1
        }
    }
    
    
    func displayQuestion() {
        timeCount = 15
        answerLabel.isHidden = true
        nextQuestion.isHidden = true
        let question = questions[indexOfSelectedQuestion]
        
        if question.answers.count == 3 {
            answer4Button.isHidden = true
            
        } else {
            answer4Button.isHidden = false
            answer4Button.setTitle(question.answers[3], for: .normal)
            
        }
        timerLabel.isHidden = false
        timerLabel.text = "Timer Started!"
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(endTimer(timer:)), userInfo: "Times Up", repeats: true)
        
        questionField.text = question.question
        answer1Button.setTitle(question.answers[0], for: .normal)
        answer2Button.setTitle(question.answers[1], for: .normal)
        answer3Button.setTitle(question.answers[2], for: .normal)
        answer4Button.setTitle(question.answers[3], for: .normal)
        playAgainButton.isHidden = true
    }
    
    
    func displayScore() {
        answer1Button.isHidden = true
        answer2Button.isHidden = true
        answer3Button.isHidden = true
        answer4Button.isHidden = true
        
        playAgainButton.isHidden = false
        nextQuestion.isHidden = true
        answerLabel.isHidden = true
        questionField.text = "Awesome!\n You got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        timer.invalidate()
        
        questionsAsked += 1
        
        let selectedQuestion = questions[indexOfSelectedQuestion]
        if (sender === answer1Button && selectedQuestion.answerIndex == 0)  || (sender === answer2Button && selectedQuestion.answerIndex == 1) || (sender === answer3Button && selectedQuestion.answerIndex == 2) || ( sender === answer4Button && selectedQuestion.answerIndex == 3) {
            correctQuestions += 1
            questionField.text = "Correct!"
            
            loadNextRoundWithDelay(seconds: 2)
            
        } else {
            
            questionField.text = "Sorry, wrong answer!"
            answerLabel.isHidden = false
            answerLabel.text = "The correct answer is \(selectedQuestion.answers[selectedQuestion.answerIndex])"
            nextQuestion.isHidden = false
        }
    }
    
    
    
    
    
    @IBAction func nextRound() {
        if questionsAsked == questionsPerRound {
            
            displayScore()
        } else {
            indexOfSelectedQuestion += 1
            displayQuestion()
        }
    }
    

    @IBAction func playAgain() {
        answer1Button.isHidden = false
        answer2Button.isHidden = false
        answer3Button.isHidden = false
        answer4Button.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        indexOfSelectedQuestion = -1
        nextRound()
    }
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

