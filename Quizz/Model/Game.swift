//
//  Game.swift
//  Quizz
//
//  Created by Martin Celavie on 26/08/2022.
//
import Foundation


class Game {
    var score = 0
    
    private var questions = [Question]()
    private var currentIndex = 0

    var state: State = .ongoing

    enum State {
        case ongoing, over
    }

    var currentQuestion: Question {
        return questions[currentIndex]
    }

    func refresh() {
        score = 0
        currentIndex = 0
        state = .over
        
        QuestionManager.shared.get { (questions) in
            self.questions = questions
            self.state = .ongoing
            let name = Notification.Name(rawValue: "QuestionsLoaded")
            let notification = Notification(name: name)
            NotificationCenter.default.post(notification)
        }
    }

    func answerCurrentQuestion(with answer: Bool) -> Bool {
        var resultat = false
        if (currentQuestion.isCorrect && answer) || (!currentQuestion.isCorrect && !answer) {
            score += 1
            resultat = true
        }
        goToNextQuestion()
        return resultat
    }

    private func goToNextQuestion() {
        let questionsTotal = questions.count - 1
        if currentIndex < questionsTotal {
            currentIndex += 1
        } else {
            finishGame()
        }
    }

    private func finishGame() {
        state = .over
    }
}
