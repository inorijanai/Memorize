//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by inori on 2023/11/13.
//

import SwiftUI

@Observable
class EmojiMemorizeGame {
    private static let emojis = ["🥹", "😅", "☺️", "😇", "😫", "😭", "😡", "😢", "🥶", "😱"]
    
    // return type cannot be inferred
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 11) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }else {
                return "⁉️"
            }
        }
    }
    
    private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
