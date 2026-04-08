//
//  PageBlock.swift
//  NotionDocumentStore
//
//  Created by Abhay Curam on 10/5/25.
//

import Foundation

public class PageBlock: CompositeBlock {
    public private(set) var blockID: String
    private var blocks: [Block] = []
    private var blockIDMap: [String : Block] = [:]
    private var blockIndexMap: [String : Int] = [:]
    
    public init(_ blockID: String) {
        self.blockID = blockID
    }
    
    public init(_ title: String, _ blockID: String) {
        self.blockID = blockID
        let titleBlock = TextBlockFactory.createTitleBlock(title)
        
    }
    
    // MARK: CompositeBlock Protocol
    public func addBlocks(_ blocks: [any Block]) {
        for block in blocks {
            if blockIDMap[block.blockID] == nil {
                self.blocks.append(block)
                blockIDMap[block.blockID] = block
                blockIndexMap[block.blockID] = self.blocks.count - 1
            } else {
                assertionFailure("A block with the id: \(block.blockID) already exists. Adding duplicate blocks is not allowed.")
                return
            }
        }
    }
    
    public func getAllBlocks() -> [any Block] {
        return blocks
    }
    
    public func getBlocks(_ blockIDs: [String]) -> [any Block] {
        var results: [any Block] = []
        for blockID in blockIDs {
            if let block = blockIDMap[blockID] { results.append(block) }
        }
        return results
    }
    
    public func removeBlocks(_ blockIDs: [String]) {
        for blockID in blockIDs {
            if let index = blockIndexMap[blockID], blockIDMap[blockID] != nil {
                blockIndexMap[blockID] = nil
                blockIDMap[blockID] = nil
                if index < blocks.count {
                    blocks.remove(at: index)
                }
            }
        }
    }
    
    public func removeLastBlocks(_ n: Int) {
        for i in 0..<n {
            if let removedBlock = blocks.popLast() {
                blockIDMap[removedBlock.blockID] = nil
                blockIndexMap[removedBlock.blockID] = nil
            } else {
                break
            }
        }
    }
    
}
