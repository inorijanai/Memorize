//
//  ContentView.swift
//  Memorize
//
//  Created by inori on 2023/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
            //changed something
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    // Views are immutable but their body can be changed
    // "@State" is just for small things
    @State var isFaceUp = false
    
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("😤").font(.largeTitle)
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
