//
//  EmojiMemoryGameView.swift
//  MemoryGame
//
//  Created by Paweł Jagła on 06/07/2020.
//  Copyright © 2020 Paweł Jagła. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var gameView: EmojiMemoryGame
    
    var body: some View {
        
        Grid(gameView.cards) { card in
                CardView(card: card).onTapGesture {
                    self.gameView.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
        
    }
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidthSize)
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Numb's control panel
    
    let cornerRadius: CGFloat = 10.0
    let lineWidthSize: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(gameView: EmojiMemoryGame())
    }
}
