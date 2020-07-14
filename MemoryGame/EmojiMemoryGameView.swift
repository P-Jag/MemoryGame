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
        VStack {
        Grid(gameView.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.5)) {
                         self.gameView.choose(card: card)
                    }
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.orange)
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.gameView.resetGame()
            }
        }, label: { Text("New game") })
        }
    }
}

struct CardView: View {
    
    var card: MemorizeGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), clockwise: true)
                    .onAppear() {
                        self.startBonusTimeAnimation()
                    }
                } else {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.move(edge: Edge.leading))
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
