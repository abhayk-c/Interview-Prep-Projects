class WordsFormedByCharacters {
    func countCharacters(_ words: [String], _ chars: String) -> Int {
        var charFrequencyMap: [Character : Int] = [:]
        for char in chars {
            if let count = charFrequencyMap[char] {
                var mutableCount = count
                mutableCount += 1
                charFrequencyMap[char] = mutableCount
            } else {
                charFrequencyMap[char] = 1
            }
        }

        var runningLen = 0
        for word in words {
            var wordCharFrequencyMap: [Character : Int] = [:]
            var shouldAddWord = true
            for char in word {
                if let globalCount = charFrequencyMap[char] {
                    if let localCount = wordCharFrequencyMap[char] {
                        var mutableLocalCount = localCount
                        mutableLocalCount += 1
                        if mutableLocalCount <= globalCount {
                            wordCharFrequencyMap[char] = mutableLocalCount
                        } else {
                            shouldAddWord = false
                            break
                        }
                    } else {
                        wordCharFrequencyMap[char] = 1
                    }
                } else {
                    shouldAddWord = false
                    break
                }
            }
            if shouldAddWord { runningLen += word.count }
        }

        return runningLen
    }
}
