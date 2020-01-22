//
//  ViewController.swift
//  Apple Pie
//
//  Created by Artyom Gurbovich on 1/21/20.
//  Copyright © 2020 Artyom Gurbovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["time", "person", "year", "way", "day", "thing", "man", "world", "life", "hand", "part", "child", "eye", "woman", "place", "work", "week", "case", "point", "government", "company", "number", "group", "problem", "fact", "question", "exit", "jacket", "game", "apple", "pie", "swift"]
    let incorrectMovesAllowed = 7
    var currentGame: Game!
    var points = 0
    let enabledColor = #colorLiteral(red: 0.8029372566, green: 0.1737360159, blue: 0.158159793, alpha: 1)
    let disabledColor = UIColor.lightGray

    @IBOutlet weak var applesLabel: UILabel!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var shelfView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shelfView.layer.shadowColor = UIColor.lightGray.cgColor
        shelfView.layer.shadowOpacity = 1
        shelfView.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        shelfView.layer.shadowRadius = 1
        shelfView.layer.cornerRadius = 3
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.9692726673, green: 0.9494388204, blue: 0.9501540493, alpha: 1), #colorLiteral(red: 0.9176880952, green: 0.8991613648, blue: 0.8977953984, alpha: 1)].map{$0.cgColor}
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        for button in letterButtons {
            button.layer.shadowOffset = CGSize(width: 0, height: 4)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 2.0
            button.layer.masksToBounds = false
        }
        newRound()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        sender.backgroundColor = disabledColor
        sender.layer.shadowColor = disabledColor.cgColor
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        points += currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func newRound() {
        let newWord = listOfWords.randomElement()!
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
        updateUI()
        for button in letterButtons {
            button.isEnabled = true
            button.backgroundColor = enabledColor
            button.layer.shadowColor = enabledColor.cgColor
        }
    }
    
    func updateUI() {
        correctWordLabel.text = currentGame.formattedWord.map{String($0)}.joined(separator: " ")
        pointsLabel.text = "Points: \(points)"
        var applesString = String(repeating: "🍎 ", count: currentGame.incorrectMovesRemaining)
        applesString.removeLast()
        applesLabel.text = applesString
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            points -= min(points, 25)
            newRound()
        } else if currentGame.word == currentGame.formattedWord {
            points += 25
            newRound()
        } else {
            updateUI()
        }
    }
}

