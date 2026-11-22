//
//  ConnectFour.swift
//  DesignProblems
//
//  Created by Abhay Curam on 7/17/26.
//

import Foundation

public enum ConnectFourCoin {
    case none, red, yellow
}

public struct ConnectFourMove {
    public let coin: ConnectFourCoin
    public let colIndex: Int
}

public typealias ConnectFourPlayerMoveHandler = ((_ move: ConnectFourMove) -> Void)

public class ConnectFourPlayer {
    public let firstName: String
    public let lastName: String
    public let playerID: String
    public var coinAssignment: ConnectFourCoin = .none
    private var moveHandler: ConnectFourPlayerMoveHandler? = nil
    
    public init(firstName: String, lastName: String, playerID: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.playerID = playerID
    }
    
    public func makeConnectFourMove(_ grid: [[ConnectFourCoin]],
                                    _ moveHandler: @escaping ConnectFourPlayerMoveHandler) {
        self.moveHandler = moveHandler
        /**
         * Imagine this is async and maybe the player takes some time, then makes a decision.
         * Blocks are a reasonable way to handle this but there are other API/communication designs as well.
         */
        self.moveHandler?(ConnectFourMove(coin: coinAssignment, colIndex: 1)) //just a dummy move
    }
}

public struct ConnectFourGameSession {
    let playerOne: ConnectFourPlayer
    let playerTwo: ConnectFourPlayer
    let sessionID: UUID
    let startTime: Date
    public fileprivate(set) var endTime: Date? = nil
    public fileprivate(set) var gameCancelled: Bool = false
    public fileprivate(set) var gameFinished: Bool = false
    public fileprivate(set) var winningPlayer: ConnectFourPlayer? = nil
}

public enum ConnectFourGameState {
    case pendingStart
    case startingGame(_ playerOne: ConnectFourPlayer, _ playerTwo: ConnectFourPlayer)
    case waitingForPlayerOneMove
    case waitingForPlayerTwoMove
    case gameEndedWithWinner(_ winner: ConnectFourPlayer)
    case gameEndedInDraw
    case gameEndedWithFailure(_ error: Error?)
    case gameCancelled
}

public protocol ConnectFourGameControllerDelegate: AnyObject {
    func gameDidStart(_ session: ConnectFourGameSession)
    func gameEndedWithWinner(_ winner: ConnectFourPlayer, _ session: ConnectFourGameSession)
    func gameEndedInDraw(_ session: ConnectFourGameSession)
    func gameEndedWithFailure(_ error: Error?, _ session: ConnectFourGameSession)
    func gameCancelled(_ session: ConnectFourGameSession)
}

public class ConnectFourGameController {
    
    private var currentSession: ConnectFourGameSession?
    private var currentState: ConnectFourGameState = .pendingStart
    private var connectFourGrid = ConnectFourGrid()
    private weak var delegate: ConnectFourGameControllerDelegate?
    
    public init(_ delegate: ConnectFourGameControllerDelegate? = nil) {
        self.delegate = delegate
    }
    
    // Creates a gameSession and kicks off our state machine.
    public func startGame(_ playerOne: ConnectFourPlayer, _ playerTwo: ConnectFourPlayer) {
        transitionToState(.startingGame(playerOne, playerTwo))
    }
    
    // Ends a game, equivalent to cancelling a game in session.
    public func endGame() {
        transitionToState(.gameCancelled)
    }
    
    public func reset() {
        //Need to think through reset a bit.
    }
    
    private func transitionToState(_ newGameState: ConnectFourGameState) {
        currentState = newGameState
        switch currentState {
        case .startingGame(let playerOne, let playerTwo):
            currentSession = ConnectFourGameSession(playerOne: playerOne, playerTwo: playerTwo, sessionID: UUID(), startTime: Date())
            connectFourGrid.reset()
            delegate?.gameDidStart(currentSession!)
            transitionToState(.waitingForPlayerOneMove)
        case .waitingForPlayerOneMove:
            guard let session = currentSession else {
                transitionToState(.gameEndedWithFailure(nil))
                return
            }
            handleMakeConnectFourMove(session.playerOne, .waitingForPlayerOneMove, .waitingForPlayerTwoMove)
        case .waitingForPlayerTwoMove:
            guard let session = currentSession else {
                transitionToState(.gameEndedWithFailure(nil))
                return
            }
            handleMakeConnectFourMove(session.playerTwo, .waitingForPlayerTwoMove, .waitingForPlayerOneMove)
        case .gameEndedWithWinner(let winner):
            currentSession?.winningPlayer = winner
            currentSession?.gameFinished = true
            currentSession?.endTime = Date()
            guard let session = currentSession else {
                transitionToState(.gameEndedWithFailure(nil))
                return
            }
            delegate?.gameEndedWithWinner(winner, session)
        case .gameEndedInDraw:
            currentSession?.gameFinished = true
            currentSession?.endTime = Date()
            guard let session = currentSession else {
                transitionToState(.gameEndedWithFailure(nil))
                return
            }
            delegate?.gameEndedInDraw(session)
        case .gameEndedWithFailure(let error):
            currentSession?.gameFinished = true
            currentSession?.endTime = Date()
            guard let session = currentSession else {
                transitionToState(.gameEndedWithFailure(nil))
                return
            }
            delegate?.gameEndedWithFailure(error, session)
        case .gameCancelled:
            currentSession?.gameCancelled = true
            currentSession?.endTime = Date()
            guard let session = currentSession else {
                transitionToState(.gameEndedWithFailure(nil))
                return
            }
            delegate?.gameCancelled(session)
        case .pendingStart:
            //Current just a no-op:
            return
        }
    
    }
    
    private func handleMakeConnectFourMove(_ player: ConnectFourPlayer,
                                           _ currentPlayerState: ConnectFourGameState,
                                           _ nextPlayerState: ConnectFourGameState) {
        player.makeConnectFourMove(connectFourGrid.coinGrid) { [weak self] move in
            guard let strongSelf = self else { return }
            let coinPlaced = strongSelf.connectFourGrid.insertCoinAt(move.coin, move.colIndex)
            if coinPlaced {
                if strongSelf.connectFourGrid.containsConnectFour {
                    strongSelf.transitionToState(.gameEndedWithWinner(player))
                } else if strongSelf.connectFourGrid.isFull {
                    strongSelf.transitionToState(.gameEndedInDraw)
                } else {
                    strongSelf.transitionToState(nextPlayerState)
                }
            } else {
                strongSelf.transitionToState(currentPlayerState)
            }
        }
    }
    
}

private struct ConnectFourCoinPosition {
    let row: Int
    let col: Int
}

public class ConnectFourGrid: CustomStringConvertible {
    
    public private(set) var coinGrid: [[ConnectFourCoin]] = [[]]
    public private(set) var containsConnectFour: Bool = false
    public private(set) var winningConnectFourCoin: ConnectFourCoin = .none
    
    /**
     * These are just property stubs, but in reality these would be either cached props
     * or lazily computed props that tell whether the grid is empty or full iterating through the board.
     */
    public private(set) var isEmpty: Bool = true
    public private(set) var isFull: Bool = false
    
    public var description: String {
        var str = ""
        for row in coinGrid {
            for coin in row {
                var coinStr = "O"
                if coin == .red {
                    coinStr = "R"
                } else if coin == .yellow {
                    coinStr = "Y"
                }
                str.append(coinStr)
            }
            str.append("\n")
        }
        return str
    }
    
    private let numRows = 6
    private let numCols = 7
    
    public init() {
        reset()
    }
    
    public func reset() {
        coinGrid = makeConnectFourGrid()
        containsConnectFour = false
        winningConnectFourCoin = .none
        isEmpty = true
        isFull = false
    }
    
    public func insertCoinAt(_ coin: ConnectFourCoin, _ col: Int) -> Bool {
        guard col >= 0 && col < numCols && !containsConnectFour else { return false }
        guard coin != .none else { return false }
        var placedCoin: ConnectFourCoinPosition? = nil
        for row in (0..<numRows).reversed() {
            if coinGrid[row][col] == .none {
                coinGrid[row][col] = coin
                placedCoin = ConnectFourCoinPosition(row: row, col: col)
                break
            }
        }
        if let placedCoinPosition = placedCoin {
            checkAndRecordGridForConnectFour(placedCoinPosition)
            return true
        }
        return false
    }
    
    /**
     * Time Complexity Analysis:
     *  - For any inserted coin at (r, c) we check all directional lines that intersect at that position (4 lines).
     *  - We check in the worst case a total of 6 positions for each line (3 spaces in each direction).
     *  - So we perform a fixed 24 checks (6*4) which is constant O(1) time complexity.
     *  - This scales regardless of board size and is much quicker than exhaustively searching the entire board.
     *  - We essentially search a "fixed" and "bounded" size subarray of the larger grid.
     */
    private func checkAndRecordGridForConnectFour(_ startPosition: ConnectFourCoinPosition) {
        var coinCount = 0
        let row = startPosition.row
        let col = startPosition.col
        let targetCoin = coinGrid[row][col]
        
        // Check NW to SE Diagonal
        if countConsecutiveCoins(targetCoin, row-1, col-1, &coinCount, rowDelta: -1, colDelta: -1) { return }
        if countConsecutiveCoins(targetCoin, row+1, col+1, &coinCount, rowDelta: 1, colDelta: 1) { return }
        // Check Vertical Column
        coinCount = 0
        if countConsecutiveCoins(targetCoin, row-1, col, &coinCount, rowDelta: -1, colDelta: 0) { return }
        if countConsecutiveCoins(targetCoin, row+1, col, &coinCount, rowDelta: 1, colDelta: 0) { return }
        // Check NE to SW Diagonal
        coinCount = 0
        if countConsecutiveCoins(targetCoin, row-1, col+1, &coinCount, rowDelta: -1, colDelta: 1) { return }
        if countConsecutiveCoins(targetCoin, row+1, col-1, &coinCount, rowDelta: 1, colDelta: -1) { return }
        // Check Horizontal Row
        coinCount = 0
        if countConsecutiveCoins(targetCoin, row, col-1, &coinCount, rowDelta: 0, colDelta: -1) { return }
        if countConsecutiveCoins(targetCoin, row, col+1, &coinCount, rowDelta: 0, colDelta: 1) { return }
    }
    
    private func countConsecutiveCoins(_ targetCoin:ConnectFourCoin,
                                       _ startRow: Int,
                                       _ startCol: Int,
                                       _ coinCount: inout Int,
                                       rowDelta: Int,
                                       colDelta: Int) -> Bool
    {
        var row = startRow
        var col = startCol
        while row >= 0 && row < numRows && col >= 0 && col < numCols {
            if coinGrid[row][col] == targetCoin {
                coinCount += 1
                // The inserted coin is implicit, so 3 contiguous neighboring coins
                // means we have a Connect Four.
                if coinCount == 3 {
                    containsConnectFour = true
                    winningConnectFourCoin = targetCoin
                    return true
                }
            } else {
                return false
            }
            row += rowDelta
            col += colDelta
        }
        
        return false
    }
    
    private func makeConnectFourGrid() -> [[ConnectFourCoin]] {
        let row: [ConnectFourCoin] = Array(repeating: .none, count: numCols)
        return Array(repeating: row, count: numRows)
    }
    
}
