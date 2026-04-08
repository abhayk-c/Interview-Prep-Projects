//
//  BlackjackCard.swift
//  DesignProblems
//
//  Created by Abhay Curam on 8/16/25.
//

public struct BlackjackCard : CardProtocol {
    
    private let suite: Suite
    private let rank: Rank
    
    public init(suite: Suite, rank: Rank) {
        self.suite = suite
        self.rank = rank
    }
    
    public func getRank() -> Rank {
        return rank
    }
    
    public func getSuite() -> Suite {
        return suite
    }
    
    public func getValues() -> [Int] {
        let suiteValue = getSuiteValue()
        switch rank {
        case .Two:
            return [suiteValue + 2]
        case .Three:
            return [suiteValue + 3]
        case .Four:
            return [suiteValue + 4]
        case .Five:
            return [suiteValue + 5]
        case .Six:
            return [suiteValue + 6]
        case .Seven:
            return [suiteValue + 7]
        case .Eight:
            return [suiteValue + 8]
        case .Nine:
            return [suiteValue + 9]
        case .Ten:
            return [suiteValue + 10]
        case .Jack:
            return [suiteValue + 10]
        case .Queen:
            return [suiteValue + 10]
        case .King:
            return [suiteValue + 10]
        case .Ace:
            return [suiteValue + 11, suiteValue + 1]
        case .Joker:
            return [-1] //sentinel value for Joker
        }
    }
    
    private func getSuiteValue() -> Int {
        switch suite {
        case .Clubs:
            return 0
        case .Diamonds:
            return 1
        case .Hearts:
            return 2
        case .Spades:
            return 3
        }
    }
    
}
