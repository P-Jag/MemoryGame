//
//  ContentView.swift
//  MemoryGame
//
//  Created by Paweł Jagła on 06/07/2020.
//  Copyright © 2020 Paweł Jagła. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var gameView: EmojiMemoryGame
    
    var body: some View {
        
        HStack {
            ForEach(gameView.cards) { card in
                CardView(card: card).onTapGesture {
                    self.gameView.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.orange)
        .font(Font.largeTitle)
        
    }
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    var body: some View {
        
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(gameView: EmojiMemoryGame())
    }
}
