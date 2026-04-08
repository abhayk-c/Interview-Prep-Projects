//
//  Card.swift
//  DesignProblems
//
//  Created by Abhay Curam on 8/16/25.
//

public protocol CardProtocol {
    init(suite: Suite, rank: Rank)
    func getSuite() -> Suite
    func getRank() -> Rank
    func getValues() -> [Int] //possible for multiple value interpretations of a Card
}
