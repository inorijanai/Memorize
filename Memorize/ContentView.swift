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
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack() {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 25)
                    .strokeBorder(lineWidth: 2)
                Text("😤").font(.largeTitle)
            }else {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.orange)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
