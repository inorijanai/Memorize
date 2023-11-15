//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by inori on 2023/10/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @State var emojis: [String] = []
    
    // Don't do this actually
    var viewModel: EmojiMemorizeGame
    
    let emotions = ["🥹", "😅", "☺️", "😇", "😫", "😭", "😡", "😢", "🥶", "😱"]
    let animals = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐮", "🐷"]
    let weathers = ["☀️", "🌤️", "☁️", "🌧️", "⛈️", "💦", "☔️", "⛄️", "🌈"]
    
    var body: some View {
        VStack{
            title
            Button("shuffle") {
                viewModel.shuffle()
            }
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            themeSwichers
        }
        .padding()
    }
    
    var title: some View{
        Text("Memorize!")
            .font(.largeTitle)
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
        .foregroundColor(.orange)
    }
    
//    var cardCountAdjusters: some View {
//        HStack{
//            cardRemover
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
    
    func themeSelector(by theme: String, symbol: String, lebal: String) -> some View{
        Button(action: {
            switch theme {
            case "emotion":
                emojis = (emotions + emotions).shuffled()
            case "animal":
                emojis = (animals + animals).shuffled()
            case "weather":
                emojis = (weathers + weathers).shuffled()
            default:
                print("No such theme")
            }
        }, label: {
            VStack{
                Image(systemName: symbol).font(.title).imageScale(.large)
                Text(lebal)
            }
        })
    }
    
    var themeSwichers: some View {
        HStack{
            Group{
                themeSelector(by: "emotion", symbol: "face.smiling", lebal: "Emotions")
                themeSelector(by: "animal", symbol: "globe.asia.australia", lebal: "Animals")
                themeSelector(by: "weather", symbol: "sun.max", lebal: "Weathers")
            }.padding([.top, .leading, .trailing])
        }
//        .font(.largeTitle)
    }
    
//    func cardAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            
//        }, label: {
//            Image(systemName: symbol)
//        })
////        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
    
//    var cardRemover: some View {
//        cardAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//    
//    var cardAdder: some View {
//        cardAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
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
