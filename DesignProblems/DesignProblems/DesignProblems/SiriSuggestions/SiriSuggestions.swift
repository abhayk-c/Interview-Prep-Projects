//
//  SiriSuggestions.swift
//  DesignProblems
//
//  Created by Abhay Curam on 11/4/25.
//

public protocol SiriCommand {
    var commandID: String {get}
}

public struct Contact {
    public let firstName: String
    public let phoneNumber: String
}

public struct SiriCallContactCommand: SiriCommand {
    public let commandID: String
    public let contact: Contact
}

public struct SiriSuggestion {
    public let suggestionID: String
    public let displayText: String
    public let siriCommand: SiriCommand
}

public protocol SiriSuggestionsProviding {
    func getClosestSuggestions(_ query: String) -> [SiriSuggestion]
}

public class SiriSuggestionsProvider: SiriSuggestionsProviding {

    public var siriSuggestions: [SiriSuggestion] = []
    
    public init(_ suggestions: [SiriSuggestion]) {
        self.siriSuggestions = suggestions
    }
    
    public func getClosestSuggestions(_ query: String) -> [SiriSuggestion] {
        // CHATGPT suggested a really cool approach leveraging a combination
        // of tries and an inverted index. It's really interesting I recommend reading.
        
        // This was my algorithmic approach, It actually suffices if the commandList
        // is relatively small, 300ish commands. But it may not scale very well as the
        // command list grows larger. I think making the API async could solve this
        // to need block the main thread. It should still return suggestions pretty fast.
        //
        // My algorithm:
        // Compute the levenshtein distance (word edit distance) from query to each word
        // in SiriSuggestionsList. The algorithm is (m*n) where m is the length
        // of first word in comparison and n is length of second word.
        //
        // After getting a set of words that have the smallest levenshtein distance
        // return the topK words. TopK could be returned by storing a map of siriSuggestions
        // to their use count. Then out of the set of words with the same levenshtein
        // distance value return the ones with the top counts. This is literally the
        // topK frequent word algorithm we just solved on leetcode using a priority queue.
        //
        // Runtime is O(L(m*n) + L*log(k)) where L is the number of suggestions in our list,
        // m is the size of query string, n is size of the siri suggestion text/word, and k is the
        // number of suggestions we return.
        return []
    }
    
}
