//
//  main.cpp
//  HashTable
//
//  Created by Abhay Curam on 7/25/24.
//

#include <functional>
#include <iostream>
#include <string>
#include "HashTable.hpp"
#include "CollidableString.hpp"
#include "Contact.hpp"
#include <unordered_map>

void printMatrix(vector<vector<int>>& matrix) {
    for (int i = 0; i < matrix.size(); i++) {
        vector<int> row = matrix[i];
        for (int j = 0; j < row.size(); j++) {
            cout << matrix[i][j] << ",";
        }
        cout << endl;
    }
}

enum RotationState { topRow, rightCol, bottomRow, leftCol };

class Solution {
public:
    vector<vector<int>> rotatedMatrix(vector<vector<int>>& sourceMatrix) {
        vector<vector<int>> newMatrix;
        for (int i = 0; i < sourceMatrix.size(); i++) {
            vector<int> rowVector(sourceMatrix.size());
            newMatrix.push_back(rowVector);
        }
        
        int startCol = 0;
        int startRow = 0;
        int endCol = (int)sourceMatrix.size() - 1;
        int endRow = endCol;
        RotationState rotationState = topRow;
        
        while (startCol <= endCol) {
            if (startCol == endCol) {
                newMatrix[startRow][startCol] = sourceMatrix[startRow][startCol];
                break;
            }
            if (rotationState == topRow) {
                int j = startRow;
                for (int i = startCol; i <= endCol; i++) {
                    newMatrix[j][endCol] = sourceMatrix[startRow][i];
                    j++;
                }
                rotationState = rightCol;
                continue;
            }
            if (rotationState == rightCol) {
                int j = endCol - 1;
                for (int i = startRow + 1; i <= endRow; i++) {
                    newMatrix[endRow][j] = sourceMatrix[i][endCol];
                    j--;
                }
                rotationState = bottomRow;
                continue;
            }
            if (rotationState == bottomRow) {
                int j = endRow - 1;
                for (int i = endCol - 1; i >= 0; i--) {
                    newMatrix[j][startCol] = sourceMatrix[endRow][i];
                    j--;
                }
                rotationState = leftCol;
                continue;
            }
            if (rotationState == leftCol) {
                int j = startCol + 1;
                for (int i = endRow - 1; i >= 0; i--) {
                    newMatrix[startRow][j] = sourceMatrix[i][startCol];
                    j++;
                }
                rotationState = topRow;
                startCol++;
                startRow++;
                endCol--;
                endRow--;
                continue;
            }
        }
        return newMatrix;
    }
};

static std::string value_to_string(std::optional<int> optionalIntValue)
{
    if (optionalIntValue.has_value()) { return std::to_string(optionalIntValue.value()); }
    return "nil";
}

static void printHashTable(vector<vector<std::pair<CollidableString, int>>> structuredKeysAndValues)
{
    std::string output = "HashTable Contents: \"";
    for (int i = 0; i < structuredKeysAndValues.size(); i++) {
        vector<std::pair<CollidableString, int>> keysAndValues = structuredKeysAndValues[i];
        if (i != 0) { output += ","; }
        output += "{";
        if (!keysAndValues.empty()) {
            for (int j = 0; j < keysAndValues.size(); j++) {
                output += "<";
                output += keysAndValues[j].first.string;
                output += ",";
                output += std::to_string(keysAndValues[j].second);
                output += ">,";
            }
        }
        output += "}";
    }
    output += "\"";
    cout << output << endl;
}

int main(int argc, const char * argv[]) {
    
    // insert code here...
    vector<vector<int>> testMatrix;
    Solution solver;
    testMatrix.push_back({1});
    cout << "Original Matrix: " << endl;
    printMatrix(testMatrix);
    cout << "Rotated Matrix: " << endl;
    vector<vector<int>> rotatedMatrix = solver.rotatedMatrix(testMatrix);
    printMatrix(rotatedMatrix);
    
    
    HashTable<Contact, std::string> contactDictionary = HashTable<Contact, std::string>();
    unordered_map<Contact, std::string> contactMap = unordered_map<Contact, std::string>();
    HashTable<CollidableString, int> hashTable = HashTable<CollidableString, int>();
    auto helloKey = CollidableString("hello", true);
    auto worldKey = CollidableString("world", true);
    auto babyKey = CollidableString("baby", true);
    auto hahaKey = CollidableString("haha", true);
    cout << "----------Test Case 1: Inserting Colliding Keys into Hash Table-----------" << endl;
    hashTable.setValueForKey(helloKey, 10);
    hashTable.setValueForKey(worldKey, 20);
    hashTable.setValueForKey(babyKey, 30);
    hashTable.setValueForKey(hahaKey, 40);
    auto helloValue = hashTable.getValueForKey(helloKey).value();
    auto worldValue = hashTable.getValueForKey(worldKey).value();
    auto babyValue = hashTable.getValueForKey(babyKey).value();
    auto hahaValue = hashTable.getValueForKey(hahaKey).value();
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    cout << "----------Test Case 2: Removing Colliding Keys from Hash Table-----------" << endl;
    hashTable.removeValueForKey(helloKey);
    hashTable.removeValueForKey(babyKey);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    cout << "----------Test Case 3: Updating Value for Existing Colliding Keys-----------" << endl;
    hashTable.setValueForKey(hahaKey, 60);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    cout << "----------Test Case 4: Updating Value for Deleted Colliding Key(s)-----------" << endl;
    hashTable.setValueForKey(helloKey, 100);
    hashTable.setValueForKey(babyKey, 200);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    cout << "----------Test Case 5: Inserting Non Colliding Keys-----------" << endl;
    auto fooKey = CollidableString("foo", false);
    auto barKey = CollidableString("bar", false);
    auto atomKey = CollidableString("atom", false);
    auto kwarkKey = CollidableString("kwark", false);
    hashTable.setValueForKey(fooKey, -100);
    hashTable.setValueForKey(barKey, -200);
    hashTable.setValueForKey(atomKey, -300);
    hashTable.setValueForKey(kwarkKey, -400);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Value for key \"foo\":" << value_to_string(hashTable.getValueForKey(fooKey)) << endl;
    cout << "Value for key \"bar\":" << value_to_string(hashTable.getValueForKey(barKey)) << endl;
    cout << "Value for key \"atom\":" << value_to_string(hashTable.getValueForKey(atomKey)) << endl;
    cout << "Value for key \"kwark\":" << value_to_string(hashTable.getValueForKey(kwarkKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    cout << "----------Test Case 6: Deleting Non Colliding Keys-----------" << endl;
    hashTable.removeValueForKey(fooKey);
    hashTable.removeValueForKey(atomKey);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Value for key \"foo\":" << value_to_string(hashTable.getValueForKey(fooKey)) << endl;
    cout << "Value for key \"bar\":" << value_to_string(hashTable.getValueForKey(barKey)) << endl;
    cout << "Value for key \"atom\":" << value_to_string(hashTable.getValueForKey(atomKey)) << endl;
    cout << "Value for key \"kwark\":" << value_to_string(hashTable.getValueForKey(kwarkKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    cout << "---------Test Case 7: Update Value for existing Non Colliding Keys:-------------" << endl;
    hashTable.setValueForKey(kwarkKey, -6000);
    hashTable.setValueForKey(barKey, -8000);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Value for key \"foo\":" << value_to_string(hashTable.getValueForKey(fooKey)) << endl;
    cout << "Value for key \"bar\":" << value_to_string(hashTable.getValueForKey(barKey)) << endl;
    cout << "Value for key \"atom\":" << value_to_string(hashTable.getValueForKey(atomKey)) << endl;
    cout << "Value for key \"kwark\":" << value_to_string(hashTable.getValueForKey(kwarkKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    cout << "---------Test Case 8: Update Value for nonexistant NonColliding Keys:-------------" << endl;
    hashTable.setValueForKey(fooKey, -10000);
    hashTable.setValueForKey(atomKey, -9000);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Value for key \"foo\":" << value_to_string(hashTable.getValueForKey(fooKey)) << endl;
    cout << "Value for key \"bar\":" << value_to_string(hashTable.getValueForKey(barKey)) << endl;
    cout << "Value for key \"atom\":" << value_to_string(hashTable.getValueForKey(atomKey)) << endl;
    cout << "Value for key \"kwark\":" << value_to_string(hashTable.getValueForKey(kwarkKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    
    
    cout << "--------------Test Case 8: Load Balancing Test-------------" << endl;
    HashTable<CollidableString, int> hashTable = HashTable<CollidableString, int>();
    auto helloKey = CollidableString("hello", true);
    auto worldKey = CollidableString("world", true);
    auto babyKey = CollidableString("baby", true);
    auto hahaKey = CollidableString("haha", true);
    auto fooKey = CollidableString("foo", false);
    auto barKey = CollidableString("bar", false);
    auto atomKey = CollidableString("atom", false);
    auto kwarkKey = CollidableString("kwark", false);
    hashTable.setValueForKey(helloKey, 10);
    hashTable.setValueForKey(worldKey, 20);
    hashTable.setValueForKey(babyKey, 30);
    hashTable.setValueForKey(hahaKey, 40);
    hashTable.setValueForKey(fooKey, -100);
    hashTable.setValueForKey(barKey, -200);
    hashTable.setValueForKey(atomKey, -300);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Value for key \"foo\":" << value_to_string(hashTable.getValueForKey(fooKey)) << endl;
    cout << "Value for key \"bar\":" << value_to_string(hashTable.getValueForKey(barKey)) << endl;
    cout << "Value for key \"atom\":" << value_to_string(hashTable.getValueForKey(atomKey)) << endl;
    cout << "Value for key \"kwark\":" << value_to_string(hashTable.getValueForKey(kwarkKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    cout << "------The Hash Table should get rebalanced now!!!!!---------" << endl;
    hashTable.setValueForKey(kwarkKey, -400);
    cout << "Value for key \"hello\":" << value_to_string(hashTable.getValueForKey(helloKey)) << endl;
    cout << "Value for key \"world\":" << value_to_string(hashTable.getValueForKey(worldKey)) << endl;
    cout << "Value for key \"baby\":" << value_to_string(hashTable.getValueForKey(babyKey)) << endl;
    cout << "Value for key \"haha\":" << value_to_string(hashTable.getValueForKey(hahaKey)) << endl;
    cout << "Value for key \"foo\":" << value_to_string(hashTable.getValueForKey(fooKey)) << endl;
    cout << "Value for key \"bar\":" << value_to_string(hashTable.getValueForKey(barKey)) << endl;
    cout << "Value for key \"atom\":" << value_to_string(hashTable.getValueForKey(atomKey)) << endl;
    cout << "Value for key \"kwark\":" << value_to_string(hashTable.getValueForKey(kwarkKey)) << endl;
    cout << "Hash Table Count: " << std::to_string(hashTable.count) << endl;
    printHashTable(hashTable.getStructuredKeysAndValues());
    
    
    return 0;
    
}
