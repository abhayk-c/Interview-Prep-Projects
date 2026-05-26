//
//  StringCompression.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 5/25/26.
//

class RunLengthEncodingCompression {
    func compress(_ chars: inout [Character]) -> Int {
        guard !chars.isEmpty else { return 0 }
        var writeIndex = 0
        var readIndex = 1
        var curToken = chars[0]
        var curTokenCount = 1
        while readIndex < chars.count {
            let nextToken = chars[readIndex]
            if nextToken == curToken {
                curTokenCount += 1
            } else {
                writeAndCompressCurrentToken(curToken, curTokenCount, &chars, &writeIndex)
                curToken = nextToken
                curTokenCount = 1
            }
            readIndex += 1
        }
        
        //flush and write remaining
        writeAndCompressCurrentToken(curToken, curTokenCount, &chars, &writeIndex)
        return writeIndex
    }
    
    func writeAndCompressCurrentToken(_ curToken: Character,
                                      _ curTokenCount: Int,
                                      _ chars: inout [Character],
                                      _ writeIndex: inout Int)
    {
        chars[writeIndex] = curToken
        writeIndex += 1
        if curTokenCount > 1 {
            let curTokenCountStr = String(curTokenCount)
            for digitChar in curTokenCountStr {
                chars[writeIndex] = digitChar
                writeIndex += 1
            }
        }
    }
}
