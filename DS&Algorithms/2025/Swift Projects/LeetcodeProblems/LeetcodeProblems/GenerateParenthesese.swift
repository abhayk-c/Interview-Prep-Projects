//
//  GenerateParenthesese.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/30/25.
//

class GenerateParenthesese {
    
    func generateParenthesis(_ n: Int) -> [String] {
        var results: [String] = []
        recursivelyGenerateParenthesis(n, "", 0, 0, &results)
        return results
    }

    func recursivelyGenerateParenthesis(_ n: Int,
                                        _ currentParens: String,
                                        _ openParensCount: Int,
                                        _ closedParensCount: Int,
                                        _ results: inout [String])
    {
        if openParensCount == n && closedParensCount == n {
            results.append(currentParens)
            return
        }

        if closedParensCount < openParensCount {
            var nextParens = currentParens
            nextParens.append(")")
            recursivelyGenerateParenthesis(n, nextParens, openParensCount, closedParensCount + 1, &results)
        }
        if openParensCount < n {
            var nextParens = currentParens
            nextParens.append("(")
            recursivelyGenerateParenthesis(n, nextParens, openParensCount + 1, closedParensCount, &results)
        }
        return
    }
}
