//
//  MemorizeGame.swift
//  Memorize
//
//  Created by inori on 2023/11/13.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
//        print(cards)
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    private(set) var score = 0
    
    mutating func choose(_ card: Card) {
//        print("chose \(card.id)")
        // a beautiful-looking use of if let
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        // bingo
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }else {
                        // not bingo
                        if(cards[chosenIndex].isSeen) {
                            if(cards[potentialMatchIndex].isSeen) {
                                score -= 2
                            }else {
                                score -= 1
                            }
                        }
                        cards[chosenIndex].isSeen = true
                        cards[potentialMatchIndex].isSeen = true
                    }
                }else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
//        print(cards)
    }
    
    mutating func newGame() {
        cards.indices.forEach { index in cards[index].reset() }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
      
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        let content: CardContent
        
        mutating func reset() {
            isFaceUp = false
            isMatched = false
        }
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
