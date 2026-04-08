//
//  ClosestPairOfEqualWords.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 8/15/25.
//

#include <unordered_map>
#include <string>
#include <vector>
#include <optional>

struct ClosestDuplicateWord {
    std::string word;
    std::pair<int, int> indices;
    int distance;
    ClosestDuplicateWord(std::string word, std::pair<int, int> indices, int distance) : word(word), indices(indices), distance(distance) {}
};

std::optional<ClosestDuplicateWord> getClosestDuplicateWords(const std::vector<string>& paragraph)
{
    std::unordered_map<std::string, int> wordIndexMap;
    std::optional<ClosestDuplicateWord> closestDuplicate = std::nullopt;
    for (int i = 0; i < paragraph.size(); i++) {
        std::string currWord = paragraph[i];
        if (wordIndexMap.find(currWord) != wordIndexMap.end()) {
            auto hashedWord = wordIndexMap.find(currWord);
            int currDistance = i - hashedWord->second;
            if (closestDuplicate.has_value()) {
                if (currDistance < closestDuplicate.value().distance) {
                    closestDuplicate = ClosestDuplicateWord(currWord, std::make_pair(hashedWord->second, i), currDistance);
                }
            } else {
                closestDuplicate = ClosestDuplicateWord(currWord, std::make_pair(hashedWord->second, i), currDistance);
            }
        }
        wordIndexMap[currWord] = i;
    }
    return closestDuplicate;
}


