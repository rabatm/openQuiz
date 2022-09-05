//
//  ViewController.swift
//  Quizz
//
//  Created by Martin Celavie on 26/08/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionView: QuestionView!
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name(rawValue: "QuestionsLoaded")
        NotificationCenter.default.addObserver(self, selector: #selector(questionsLoaded), name: name, object: nil)
        startNewGame()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragQuestionView(_:)))
        questionView.addGestureRecognizer(<#T##gestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>)
    }

    
    @objc func questionsLoaded() {
        newGameButton.isHidden = false
        activityIndicator.isHidden = true
        
        questionView.title = game.currentQuestion.title
        
    }
    @IBAction func didTapNewGameButton() {
        startNewGame()
    }
    
    private func startNewGame() {
        activityIndicator.isHidden = false
        newGameButton.isHidden = true
        
        questionView.title = " Loading ..."
        questionView.style = .standart
        
        scoreLabel.text = "0 / 10"
        
        game.refresh()
    }
    func dragQuestionView(_ sender: UIPanGestureRecognizer)
    {
        if game.state == .ongoing {
            switch sender.state {
            case .began, .changed:
                transformQuestionViewWith(gesture: sender)
            case .cancelled, .ended:
                answerquestion()
            default:
                break
            }
        }
    }
    private func transformQuestionViewWith(gesture: UIPanGestureRecognizer)
    {
        
    }
    
    private func answerquestion()
    {
        
    }
}


