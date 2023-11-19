//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by inori on 2023/11/13.
//

import SwiftUI

@Observable
class EmojiMemorizeGame {
    init() {
        var currentThemeName = "default"
        var currentColor = "default"
        if let randomTheme = EmojiMemorizeGame.themeColors.randomElement() {
            currentThemeName = randomTheme.key
            currentColor = randomTheme.value
        }
        
        // FIXME: initializers?
        // I don't know why I can't initialize memoryGameModel with themeModel here.
        let localTheme = EmojiMemorizeGame.createTheme(themeName: currentThemeName, colorName: currentColor)
        themeModel = localTheme
        memoryGameModel = EmojiMemorizeGame.createMemoryGame(theme: localTheme)
    }
    
    static func createTheme(themeName: String, colorName: String) -> Theme {
        Theme(themeName, colorName) {_ in 
            themeEmojis[themeName]!
        }
    }
    
    static var themeColors = ["Helloween": "orange", "Weather": "blue", "Food": "red", "Planet": "purple", "Face": "yellow", "Sport": "green"]
    
    static var themeEmojis = [
        "Helloween": ["🎃", "🦇", "🕸️", "🧙‍♀️", "👻", "🍬", "🍭", "🕷️", "🧟‍♂️", "🕯️", "🌙", "🧛"],
        "Weather": ["☔", "🌪️", "❄️", "☀️", "🌧️", "🌊", "🌫️", "⚡", "🌈", "🌋", "🌄", "🌅"],
        "Food": ["🍔", "🍕", "🌮", "🍜", "🍰", "🍦", "🍩", "🍇", "🍓", "🍌", "🍳", "🍟"],
        "Planet": ["🌍", "🌙", "🌌", "🚀", "🛰️", "🪐", "🌠", "🌟", "🌕", "🌑", "🌘", "🌗"],
        "Face": ["😊", "😎", "😍", "😋", "😜", "😂", "😢", "😡", "😇", "🙄", "😬", "🤔"],
        "Sport": ["⚽", "🏀", "🎾", "🏓", "🏈", "🏐", "🏋️‍♀️", "🚴‍♂️", "🏄‍♂️", "🤸‍♀️", "🏊‍♂️", "🎳"]
    ]
    
    // return type cannot be inferred
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex){
                return theme.emojis[pairIndex]
            }else {
                return "⁉️"
            }
        }
    }
    
    private var memoryGameModel: MemoryGame<String>
    
    private var themeModel: Theme
    
    var score: Int {
        return memoryGameModel.score
    }
    
    var color: Color {
        get {
            switch themeModel.color {
            case "orange":
                return Color.orange
            case "blue":
                return Color.blue
            case "red":
                return Color.red
            case "purple":
                return Color.purple
            case "yellow":
                return Color.yellow
            case "green":
                return Color.green
            default:
                return Color.accentColor
            }
        }
    }
    
    var themeName: String {
        get { themeModel.name }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return memoryGameModel.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        memoryGameModel.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        memoryGameModel.choose(card)
    }
    
    func newGame() {
        memoryGameModel.newGame()
    }
}
