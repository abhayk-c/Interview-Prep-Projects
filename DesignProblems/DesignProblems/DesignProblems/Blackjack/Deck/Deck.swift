//
//  Deck.swift
//  DesignProblems
//
//  Created by Abhay Curam on 8/16/25.
//

public class Deck<Card: CardProtocol> {
    
    var cardsArray: [Card]
    
    public init() {
        self.cardsArray = []
        self.initializeCardsArray()
    }
    
    public init(cards: [Card]) {
        self.cardsArray = cards
    }
    
    public func top() -> Card? {
        return cardsArray.last
    }
    
    public func pop() -> Card? {
        return cardsArray.popLast()
    }
    
    public func insertTop(_ card: Card) {
        cardsArray.append(card)
    }
    
    public func insertBottom(_ card: Card) {
        cardsArray.insert(card, at: 0)
    }
    
    public func insertAt(_ index: Int, _ card: Card) {
        guard index < cardsArray.count else { return }
        cardsArray.insert(card, at: index)
    }
    
    public func shuffle() {
        //Shuffle API. This is a stub, but it would do a fisher yates style shuffle of the deck.
        return
    }
    
    private func initializeCardsArray() {
        for i in 0..<4 {
            for j in 0..<14 {
                cardsArray.append(Card(suite: Suite(rawValue: i)!, rank: Rank(rawValue: j)!))
            }
        }
    }
    
}
