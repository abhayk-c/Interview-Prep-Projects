//
//  NotionDocumentStore.swift
//  NotionDocumentStore
//
//  Created by Abhay Curam on 10/5/25.
//


/**
 * Things you have learned and next steps:
 *
 * 1. Verify the invariants in the interview. Can we store duplicate blocks?
 *    Cycle Detection (can't have cycles). Need to more explicitly state the invariants
 *    and handle those properly. For cycle detection the main thing to worry about is not adding
 *    a parent as a childBlock to a block that is already in the parent's subtree. This would create
 *    an infinite cycle. This can be avoided with parent/back pointers.
 *    To ensure uniqueness (can't add the same block with the same blockID anywhere in the tree)
 *    first each block should generate its own UUID that would be a cleaner, less error-prone design.
 *    Then second, introduce parent/backPointer to each block OR a "isAttached" flag. Then a block
 *    that is added as a child you can set the flag to true. Then this way this flag can be checked
 *    before being added.
 *
 * 2. Implement some basic test cases:
 *    - Add a empty page
 *    - Add a page with all block content
 *    - Add a page with block content and a childPage
 *    - Somehow try to print/verify.
 */


public class NotionDocumentStore
{
    private var rootPages: [PageBlock] = []
    private var pageIDMap: [String : PageBlock] = [:]
    private var pageIndexMap: [String : Int] = [:]
    
    public func addNewPage(_ pageBlock: PageBlock) {
        addNewPages([pageBlock])
    }
    
    public func addNewPages(_ pageBlocks: [PageBlock]) {
        for pageBlock in pageBlocks {
            if pageIDMap[pageBlock.blockID] == nil {
                rootPages.append(pageBlock)
                pageIDMap[pageBlock.blockID] = pageBlock
                pageIndexMap[pageBlock.blockID] = rootPages.count - 1
            } else {
                assertionFailure("A page with the id: \(pageBlock.blockID) already exists. Adding duplicate pages is not allowed.")
                return
            }
        }
    }
    
    public func removeLastPages(_ n: Int) {
        for i in 0..<n {
            if let removedPage = rootPages.popLast() {
                pageIDMap[removedPage.blockID] = nil
                pageIndexMap[removedPage.blockID] = nil
            } else {
                break
            }
        }
    }
    
    public func removePages(_ pageIDs: [String]) {
        for pageID in pageIDs {
            if let index = pageIndexMap[pageID], pageIDMap[pageID] != nil {
                pageIndexMap[pageID] = nil
                pageIDMap[pageID] = nil
                if index < rootPages.count {
                    rootPages.remove(at: index)
                }
            }
        }
    }
    
    public func getAllRootPages() -> [PageBlock] {
        return rootPages
    }
    
    public func getRootPage(_ pageID: String) -> PageBlock? {
        return getRootPages([pageID]).first
    }
    
    public func getRootPages(_ pageIDs: [String]) -> [PageBlock] {
        var results: [PageBlock] = []
        for pageID in pageIDs {
            if let pageBlock = pageIDMap[pageID] { results.append(pageBlock) }
        }
        return results
    }
    
}
