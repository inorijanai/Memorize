//
//  ContentView.swift
//  Memorize
//
//  Created by inori on 2023/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = []
    
    let emotions = ["🥹", "😅", "☺️", "😇", "😫", "😭", "😡", "😢", "🥶", "😱"]
    let animals = ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐮", "🐷"]
    let weathers = ["☀️", "🌤️", "☁️", "🌧️", "⛈️", "💦", "☔️", "⛄️", "🌈"]
    
    var body: some View {
        VStack{
            title
            ScrollView{
                cards
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
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem(), GridItem()]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
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
    let content: String
    // Views are immutable but their body can be changed
    // "@State" is just for small things
    @State var isFaceUp = false
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            // apply .opacity() to all views in Group
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
