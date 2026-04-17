//
//  BlackjackGame.swift
//  DesignProblems
//
//  Created by Abhay Curam on 4/16/26.
//

/**
 * Look at the pictures you took on your iPhone for functional and non-functional requirements
 */

public protocol Hand {
    var facedownCards: [Any] { get }
    var faceupCards: [Any] { get }
    func addFacedownCard()
    func addFaceupCard()
    func getValue() -> Int
}


public protocol Player {
    var name: String { get }
    var playerID: String { get }
    var hand: Hand { get }
}

public class BlackjackPlayer: Player {
    public let name: String
    public let playerID: String
    public let hand: Hand
    public func
}

/** Still working on this problem but here were the next steps:
 
 
 - Trying to design the the actual GameState next.
 - I am thinking of a GameController object that starts up a game and manages some sort of a session.
 - It's going to be an event driven loop with some basic states like:

        - initializingGame (shuffles deck, deals cards to everyone round robin, transitions to starting gamePlay)
        - startGamePlay (basically just kicks off and starts the round robin game. Starts with the dealer first since the dealer
          could hit blackjack right away)
        - waitingForPlayerMove (waiting for hit, stay, bust decisions from player. This is like a waiting/interrupt state)
        - gameFinished (some sort of terminal state when the dealer goes past 17, hits blackjack, or busts)
 
 - There needs to be some way of encapsulating a Table, GameSession, and who is currently still on the table playing, whose already won (hit blackjack), whose lost. Basically the GameController's data model layer. So I need to design this out.
 
 - Finally the deck of cards.. There is a good amount left to do.
 
 
 */
