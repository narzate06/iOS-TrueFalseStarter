//
//  Questions.swift
//  TrueFalseStarter
//
//  Created by Noe Arzate on 1/29/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation


struct Question {
    let questions: String
    let answers: [String]
    let answerIndex: Int
}

var questions = [
    Question(questions: "This was the only US President to serve more than two consecutive terms.", answers: ["George Washington", "Franklink D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], answerIndex: 2),
    Question(questions: "Which of the following countries has the most residents?", answers: ["Nigeria", "Russia", "Iran", "Vietnam"], answerIndex: 1),
    Question(questions: "In what year was the United Nations founded?", answers: ["1918", "1919", "1945", "1954"], answerIndex: 3),
    Question(questions: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", answers: ["Paris", " Washington DC", " New York City", " Boston"], answerIndex: 3),
    Question(questions: "Which nation produces the most oil?", answers: ["Iran", "Iraq", "Brazil", "Canada"], answerIndex: 4),
    Question(questions: "Which country has most recently won consecutive World Cups in Soccer?" , answers: ["Italy", "Brazil", "Agentina", "Spain"], answerIndex: 2),
    Question(questions: "Which of the following rivers is longest?", answers: ["Yangtze", "Mississippi", "Congo", "Mekong"], answerIndex: 2),
    Question(questions: "Which city is the oldest?", answers: ["Mexico City", "Cape Town", "San Juan", "Sydney"], answerIndex: 1),
    Question(questions: "Which country was the first to allow wowen to vote in national elections?", answers: ["Poland", "United States", "Sweden", "Senegal"], answerIndex: 1),
    Question(questions: "Which of these countries won the most medals in the 2012 Summer Games?", answers: ["France", "Germany", "Japan", "Great Britian"], answerIndex: 4)
]

func shuffleOnce() {
    let count = questions.count - 1
    let randomIndex = Int(arc4random_uniform(UInt32(count)))
    questions.append(questions.remove(at: randomIndex))
}

func shuffle() {
    for _ in questions {
        shuffleOnce()
    }
}


















