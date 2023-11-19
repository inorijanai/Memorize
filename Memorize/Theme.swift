//
//  Theme.swift
//  Memorize
//
//  Created by inori on 2023/11/17.
//

import Foundation

struct Theme {
    var name: String
    var color: String
    var emojis: [String]
    var numberOfPairs: Int = Int.random(in: 2...12)
    
    init(_ themeName: String, _ themeColor: String, _ emojiFactory: (String) -> [String]) {
        name = themeName
        color = themeColor
        emojis = emojiFactory(name).shuffled()
    }
}
