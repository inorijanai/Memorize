//
//  MemorizeApp.swift
//  Memorize
//
//  Created by inori on 2023/10/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var game = EmojiMemorizeGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
