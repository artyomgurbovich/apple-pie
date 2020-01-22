//
//  Game.swift
//  Apple Pie
//
//  Created by Artyom Gurbovich on 1/22/20.
//  Copyright © 2020 Artyom Gurbovich. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        return word.map{guessedLetters.contains($0) ? String($0) : "_"}.reduce("", +)
    }
    
    mutating func playerGuessed(letter: Character) -> Int {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
            return 0
        }
        return 50 / word.count * word.filter{$0 == letter}.count
    }
}
