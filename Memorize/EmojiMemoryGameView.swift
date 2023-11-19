//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by inori on 2023/10/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
//    @State var emojis: [String] = []
    
    // Don't do this actually
    @State var viewModel: EmojiMemorizeGame

    var body: some View {
        Group{
            Text("Current Theme: \(viewModel.themeName)")
                .font(.title)
            Text("Scores: \(viewModel.score)")
            Button("New Game") {
                viewModel = EmojiMemorizeGame()
            }
            ScrollView{
                cards.animation(.default, value: viewModel.cards)
            }
            .padding([.leading, .bottom, .trailing])
        }
        .foregroundColor(viewModel.color)
    }

    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.color)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    // Views are immutable but their body can be changed
    // "@State" is just for small things
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            // apply .opacity() to all views in Group
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame())
}
