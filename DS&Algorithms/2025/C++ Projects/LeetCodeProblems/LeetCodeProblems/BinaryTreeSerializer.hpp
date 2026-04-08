//
//  BinaryTreeSerializer.hpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 7/1/25.
//

#include "TreeNode.hpp"

class BinaryTreeSerializer {
    
public:
    std::string serialize(TreeNode* root) {
        std::string data = "";
        recursivelySerializeTree(root, data);
        data.pop_back();
        return data;
    }
    
    TreeNode* deserialize(std::string& data) {
        std::vector<std::string> tokenizedData = tokenizeDataString(data);
        if (tokenizedData.empty()) { return nullptr; }
        auto result = recursivelyDeserializeTree(tokenizedData, 0);
        return result.first;
    }
    
private:
    void recursivelySerializeTree(TreeNode *node, std::string& buffer) {
        if (node == nullptr) {
            buffer.append("#,");
            return;
        }
        buffer.append(std::to_string(node->val) + ",");
        recursivelySerializeTree(node->left, buffer);
        recursivelySerializeTree(node->right, buffer);
    }
    
    std::pair<TreeNode*, int> recursivelyDeserializeTree(const std::vector<std::string>& data, int index) {
        if (data[index] == "#") {
            return {nullptr, index};
        }
        TreeNode* newNode = new TreeNode(std::stoi(data[index]));
        std::pair<TreeNode*, int> leftResult = recursivelyDeserializeTree(data, index + 1);
        newNode->left = leftResult.first;
        std::pair<TreeNode*, int> rightResult = recursivelyDeserializeTree(data, leftResult.second + 1);
        newNode->right = rightResult.first;
        return {newNode, rightResult.second};
    }
    
    std::vector<std::string> tokenizeDataString(const std::string& dataStr) {
        std::vector<std::string> tokens;
        std::stringstream ss(dataStr);
        std::string token;
        while (std::getline(ss, token, ',')) {
            if (!token.empty()) {
                tokens.push_back(token);
            }
        }
        return tokens;
    }
    
};

