import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var game: MemorizeGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemorizeGame<String> {
        let emojis = ["🦄","🐱", "🦊"]
        return MemorizeGame<String>(numberOfpairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the model
    
    var cards: Array<MemorizeGame<String>.Card> {
        game.cards
    }
    
    //MARK: - Intent(s)
    
    func choose(card: MemorizeGame<String>.Card) {
        game.choose(card: card)
    }
}
