//
//  Block.swift
//  NotionDocumentStore
//
//  Created by Abhay Curam on 10/5/25.
//

public protocol Block {
    var blockID: String { get }
}

public protocol CompositeBlock: Block {
    func addBlocks(_ blocks: [any Block])
    func getAllBlocks() -> [any Block]
    func getBlocks(_ blockIDs: [String]) -> [any Block]
    func removeBlocks(_ blockIDs: [String])
    func removeLastBlocks(_ n: Int)
}
