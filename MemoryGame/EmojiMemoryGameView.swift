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
    
    var card: MemorizeGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    //MARK: - Numb's control panel
    
    private let fontScaleFactor: CGFloat = 0.70
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(gameView: game)
    }
}
