//
//  Hand.swift
//  DesignProblems
//
//  Created by Abhay Curam on 8/16/25.
//

// Rough idea of what a Hand may look like
// I made it a interface just to stub out the API.
// Communicating over a protocol would be cleaner as well.
//
// I can't really imagine a need for different "subclasses"
// of hands depending on the game type, but its possible.
// Seems reasonable to have each Player hold a single hand class
// and the different "typed" Card's takes care of the values/denominations.
// I could be wrong though... I am thinking in terms of casino style card games.
public protocol HandProtocol {
    associatedtype Card: CardProtocol
    func addCard(card: Card, faceUp: Bool)
    func burnCard() -> Card?
    func getCards() -> [Card]
    func getFaceUpCards() -> [Card]
    func getFaceDownCards() -> [Card]
    func getCardCount() -> Int
    func getHandValue() -> Int
    func setHandValue(_ value: Int)
}
