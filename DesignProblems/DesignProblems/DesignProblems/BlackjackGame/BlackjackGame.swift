//
//  BlackjackGame.swift
//  DesignProblems
//
//  Created by Abhay Curam on 4/16/26.
//

import Foundation

/**
 * MARK - Generic classes, structs, protocols, and data structures
 */

public enum CardSuite {
    case clubs, diamonds, hearts, spades
}

public enum CardRank {
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace, joker
}

public struct Card {
    let suite: CardSuite
    let rank: CardRank
}

public struct CardArrayFactory {
    
    public static func singleDeck() -> [Card] { return [] }
    
    public static func doubleDeck() -> [Card] {
        return  singleDeck() + singleDeck()
    }
    
    public static func custom() -> [Card] { return [] }
}

/**
 * Simple object/data structure for encapsulating a deck of cards.
 * Logic of dealing, managing a burn pile, etc. is all dependent on the game. Just a basic
 * deck like this is all thats needed for blackjack with the right Dealer state implementation
 */
public class CardDeck {
    private var cards: [Card]
    
    public init(_ cards: [Card]) {
        self.cards = cards
    }
    
    public func popCard() -> Card? {
        return popCards(1).first
    }
    
    public func popCards(_ cardCount :Int) -> [Card] {
        var count = 0
        var cardsToDeal: [Card] = []
        while count < cardCount, let cardToDeal = cards.popLast() {
            cardsToDeal.append(cardToDeal)
            count += 1
        }
        return cardsToDeal
    }
    
    public func addCards(_ cards: [Card]) {
        self.cards.append(contentsOf: cards)
    }
    
    public func shuffle() {
        // Imagine we implement a Fisher Yates style shuffle on cardPile.
    }
}

public protocol Hand {
    var facedownCards: [Card] { get }
    var faceupCards: [Card] { get }
    mutating func addFacedownCard(_ card: Card)
    mutating func addFaceupCard(_ card: Card)
}

public protocol Player {
    associatedtype PlayerHand: Hand
    var name: String { get }
    var playerID: String { get }
    var hand: PlayerHand { get set }
}


/**
 * MARK - BlackJack Game specific classes, protocol, structs, and Data Structures.
 */

public struct BlackJackPlayerHand: Hand {
    public private(set) var facedownCards: [Card]
    public private(set) var faceupCards: [Card]
    
    public var blackjack: Bool {
        get {
            return getValue().contains([21])
        }
    }
    
    public var busted: Bool {
        get {
            for score in getValue() {
                if score <= 21 { return false }
            }
            return true
        }
    }
    
    public mutating func addFaceupCard(_ card: Card) {
        faceupCards.append(card)
    }
    
    public mutating func addFacedownCard(_ card: Card) {
        facedownCards.append(card)
    }
    
    public func getValue() -> [Int] {
        // Imagine we implement a small algo to determine the blackJack hand
        // value from the facedown and faceup cards. Because there can be multiple
        // values in blackjack we return an array.
        // This is the whole reason for the protocol oriented approach here, each
        // game type can have its own value calculation so it has its own hand type.
        // We encapsulate the value calculation in the Hand type itself.
        return [0]
    }
}

public enum BlackJackPlayerMove {
    case hit
    case stay
}

public typealias BlackJackPlayerMoveHandler = ((_ nextMove: BlackJackPlayerMove) -> Void)

public class BlackJackPlayer: Player, Hashable {
    public let name: String
    public let playerID: String
    public var hand: BlackJackPlayerHand
    public private(set) var currentHandValue: Int
    fileprivate var moveHandler: BlackJackPlayerMoveHandler?
    
    public init(name: String,
                playerID: String,
                hand: BlackJackPlayerHand) {
        self.name = name
        self.playerID = playerID
        self.hand = hand
        self.currentHandValue = 0
    }
    
    public func getNextMove(_ moveHandler: @escaping BlackJackPlayerMoveHandler) {
        self.moveHandler = moveHandler
        // Player makes a move asynchronously (time can pass for them to make a decision).
        // We model this leveraging blocks.
        self.moveHandler?(.stay) //This is just a dummy move for now.
    }
    
    public static func ==(lhs: BlackJackPlayer, rhs: BlackJackPlayer) -> Bool {
        return lhs.playerID == rhs.playerID
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(playerID)
    }
}

public class BlackJackDealer: BlackJackPlayer {
    public override func getNextMove(_ moveHandler: @escaping BlackJackPlayerMoveHandler) {
        // We leverage subclassing here because a BlackJack dealer's "move"
        // logic is different from that of a Player. Dealer's have to keep hitting until 16.
        self.moveHandler = moveHandler
        self.moveHandler?(.stay)
    }
}

/**
 * This design ended up conflating and combining concerns a bit. I cut corners and wanted a
 * Table object to encapsulate the table data model for the game the orchestrator could use,
 * represent a read-only "record" of who won/lost of the game for the client, and could even serve
 * as the session.
 *
 * A better design is to just update the startGame() API to accept a list of Players and a Dealer.
 * Internally when the game starts the Orchestrator class just creates a "session" object with an ID
 * to represent the ongoing game, this session can be read-only so a client can read it.
 *
 * When a game is over a GameRecord struct can be created with all the metadata of the game
 * like who won, who lost, etc, that basically becomes a read-only report and record of the game.
 */
public struct BlackJackTable {
    let tableID: String
    let dealer: BlackJackDealer
    // we can assume an ordering is maintained of players, then dealer at the end
    // so we can just go round-robin
    public fileprivate(set) var players: [BlackJackPlayer]
    
    public fileprivate(set) var winningPlayers = Set<BlackJackPlayer>()
    public fileprivate(set) var bustedPlayers = Set<BlackJackPlayer>()
    public fileprivate(set) var playersInGame = Set<BlackJackPlayer>()
    
    public init(_ players: [BlackJackPlayer],
                _ dealer: BlackJackDealer) {
        self.players = players
        self.dealer = dealer
        self.players.append(dealer)
        self.tableID = UUID().uuidString
    }
}

public enum BlackJackGameType {
    case singleDeck, doubleDeck
}

public class BlackJackGame {
    /**
     * A session may be useful where we associate a Table with a Session and then also add information
     * like a sessionID, game start time, game end time, who were the people playing in the session,
     * winners, losers. Trying to think if its something the client needs to pass in, internal to the class,
     * or maybe internal to the class but then also exposed.
     */
    public private(set) var table: BlackJackTable?
    public var gameInSession: Bool {
        get {
            // We should check if the gameState is not equal to startingGame, dealingPlayer, or dealingDealer.
            return true
        }
    }
    
    private enum  BlackJackGameState {
        case pendingStart
        case startGame
        case dealCurrentPlayer
        case moveToNextPlayer
        case concludeGame
        case endGameWithError(_ error: Error?)
    }
    
    private var currentState: BlackJackGameState = .pendingStart
    private var currentPlayer: BlackJackPlayer?
    private var currentPlayerIndex: Int = 0
    
    private var gameType: BlackJackGameType
    private var cardDeck: CardDeck
    
    public init(_ gameType: BlackJackGameType) {
        self.gameType = gameType
        let cards = (gameType == .singleDeck) ? CardArrayFactory.singleDeck() : CardArrayFactory.doubleDeck()
        cardDeck = CardDeck(cards)
    }
    
    public func startGame(table: BlackJackTable) {
        // Imagine some guard and error if this API is called while a game is in session
        self.table = table
        transitionToState(.startGame)
    }
    
    public func endGame() {
        // no op for now.
    }
    
    public func reset() {
        // clears the game/game state.
    }
    
    private func transitionToState(_ state: BlackJackGameState) {
        currentState = state
        switch currentState {
        case .startGame:
            handleStartGame()
        case .dealCurrentPlayer:
            handleDealCurrentPlayer()
        case .moveToNextPlayer:
            handleMoveToNextPlayer()
        case .concludeGame:
            print("Game finished")
            // This state the Game has successfully concluded. Imagine in this state the winners and
            // losers are all "gathered", and then we just broadcast this information.
            // This can be via a Delegate API, Observables, AsyncStream, its irrelevant.
            // We'll hold on to the state for book-keeping so a client can inspect the game
            // record (BlackJackTable object), everything gets reset if a client calls startGame again.
        case .endGameWithError(let error):
            print("Game essentially ended/cancelled with a failure: \(error)")
            // Similar to the above but its the failure case. We gotta just report back to the delegate
            // a failure or a game end.
        case .pendingStart:
            print("This is like a sentinel/default state.")
            //Imagine a sentinel/default state here.
            //Likely a state that is invoked when reset is called imagine the whole Game state
            //gets completely reset here.
        }
    }
    
    private func handleStartGame() {
        guard let currentTable = table, currentTable.players.count >= 2 else {
            transitionToState(.endGameWithError(nil))
            return
        }
        currentPlayerIndex = 0
        for player in currentTable.players {
            table?.playersInGame.insert(player)
        }
        cardDeck.shuffle()
        transitionToState(.dealCurrentPlayer)
    }
    
    private func handleDealCurrentPlayer() {
        guard let currentTable = table, currentTable.players.count >= 2 else {
            transitionToState(.endGameWithError(nil))
            return
        }
        let playerToDeal = currentTable.players[currentPlayerIndex]
        guard currentTable.playersInGame.contains(playerToDeal) else {
            transitionToState(.moveToNextPlayer)
            return
        }
        guard let cardToDeal = cardDeck.popCard() else {
            transitionToState(.concludeGame)
            return
        }
        playerToDeal.hand.addFaceupCard(cardToDeal)
        if playerToDeal.hand.busted {
            table?.bustedPlayers.insert(playerToDeal)
            table?.playersInGame.remove(playerToDeal)
            if playerToDeal is BlackJackDealer {
                transitionToState(.concludeGame)
            } else {
                transitionToState(.moveToNextPlayer)
            }
        } else if playerToDeal.hand.blackjack {
            table?.winningPlayers.insert(playerToDeal)
            table?.playersInGame.remove(playerToDeal)
            if playerToDeal is BlackJackDealer {
                transitionToState(.concludeGame)
            } else {
                transitionToState(.moveToNextPlayer)
            }
        } else {
            playerToDeal.getNextMove { [weak self] nextMove in
                guard let strongSelf = self else { return }
                if nextMove == .hit {
                    strongSelf.transitionToState(.dealCurrentPlayer)
                } else {
                    strongSelf.transitionToState(.moveToNextPlayer)
                }
            }
        }
    }
    
    private func handleMoveToNextPlayer() {
        guard let currentTable = table, currentTable.players.count >= 2 else {
            transitionToState(.endGameWithError(nil))
            return
        }
        guard !currentTable.playersInGame.isEmpty else {
            transitionToState(.concludeGame)
            return
        }
        currentPlayerIndex += 1
        guard currentPlayerIndex < currentTable.players.count else {
            currentPlayerIndex = 0
            return
        }
        transitionToState(.dealCurrentPlayer)
    }
}




