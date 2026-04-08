//
//  CharacterTrie.swift
//  Trie
//
//  Created by Abhay Curam on 10/8/25.
//

public struct TrieCursor {
    public var terminalWorld: String? {
        get {
            return nodePtr.terminalWord
        }
    }
    fileprivate var nodePtr: TrieNode
}

private class TrieNode {
    fileprivate var currentCharacter: Character
    fileprivate var count: Int
    fileprivate var terminalWord: String?
    fileprivate var children: [TrieNode?]
    public init(_ currentCharacter: Character) {
        self.currentCharacter = currentCharacter
        self.children = Array(repeating: nil, count: 26)
        self.count = 0
    }
}

public class CharacterTrie {
    
    private var rootNode: TrieNode
    private let characterIndexMap: [Character : Int] = ["a":0,"b":1,"c":2,"d":3,"e":4,"f":5,"g":6,"h":7,"i":8,"j":9,"k":10,"l":11,"m":12,"n":13,"o":14,"p":15,"q":16,"r":17,"s":18,"t":19,"u":20,"v":21,"w":22,"x":23,"y":24,"z":25]
    
    public var rootCursor: TrieCursor {
        get {
            return TrieCursor(nodePtr: rootNode)
        }
    }
    
    public init(_ words: Set<String>) {
        rootNode = TrieNode(" ")
        loadTrieWithWords(words)
    }
    
    public func insertWord(_ word: String) {
        let wordCharacterArray = Array(word)
        var cursorNode = rootNode
        for character in wordCharacterArray {
            guard let index = characterIndexMap[character] else { return }
            if let nextCharacterNode = cursorNode.children[index] {
                cursorNode = nextCharacterNode
            } else {
                let newCharacterNode = TrieNode(character)
                cursorNode.children[index] = newCharacterNode
                cursorNode.count += 1
                cursorNode = newCharacterNode
            }
        }
        cursorNode.terminalWord = word
    }
    
    public func moveToCharacterIfAvailable(_ cursor: TrieCursor, _ char: Character) -> TrieCursor? {
        let cursorNode = cursor.nodePtr
        guard let index = characterIndexMap[char] else { return nil }
        if let nextCharacterNode = cursorNode.children[index] {
            return TrieCursor(nodePtr: nextCharacterNode)
        }
        return nil
    }
    
    private func loadTrieWithWords(_ words: Set<String>) {
        for word in words {
            insertWord(word)
        }
    }
    
}
