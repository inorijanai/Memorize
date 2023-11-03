//
//  ContentView.swift
//  Memorize
//
//  Created by inori on 2023/10/23.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = [ "😤", "😇", "🤔", "😃", "😃" ]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
            //changed something
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    let content: String
    // Views are immutable but their body can be changed
    // "@State" is just for small things
    @State var isFaceUp = true
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
