//
//  HashTable.hpp
//  HashTable
//
//  Created by Abhay Curam on 7/25/24.
//

#include <functional>
#include <optional>
#include <string>
#include "List.hpp"

static const float kLoadFactorThresholdBeta = 2.0;
static const int kTableReloadMultiplierTheta = 2 * (int)kLoadFactorThresholdBeta;

/**
 * Basic Hash Table implementation that leverages linked list
 * separate chaining as a collision resolution policy.
 *
 * It's crazy but because this class leverages templated generics
 * we actually can't separate the header and implementation files
 * in C++ because the linker can't handle it. As a result the entire
 * implementation needs to be in the header file. See this writeup:
 * https://isocpp.org/wiki/faq/templates#templates-defn-vs-decl
 */
template <
    class Key,
    class Value,
    class KeyHash = std::hash<Key>,
    class KeyEqual = std::equal_to<Key>
>
class HashTable {
    
private:
    struct HashTableNode {
        Key key;
        Value value;
        HashTableNode(Key key, Value value) : key{key}, value(value) {}
    };
    KeyHash keyHash;
    KeyEqual keysEqual;
    int numBuckets;
    List<HashTableNode> **buckets;
    
    void rebalanceHashTableIfApplicable()
    {
        const float loadFactor = (float)count / (float)numBuckets;
        if (loadFactor >= kLoadFactorThresholdBeta) {
            vector<HashTableNode> allKeysAndValues;
            for (int i = 0; i < numBuckets; i++) {
                List<HashTableNode> *currentList = buckets[i];
                if (currentList != nullptr) {
                    for (auto it = currentList->begin(); it != currentList->end(); it++) {
                        allKeysAndValues.push_back(*it);
                    }
                }
            }
            eraseAll();
            numBuckets *= kTableReloadMultiplierTheta;
            buckets = new List<HashTableNode>*[numBuckets] {nullptr};
            for (int i = 0; i < allKeysAndValues.size(); i++) {
                setValueForKey(allKeysAndValues[i].key, allKeysAndValues[i].value);
            }
        }
    }
    
public:
    
    int count;
    
    HashTable() 
    {
        keyHash = KeyHash();
        keysEqual = KeyEqual();
        count = 0;
        numBuckets = 4;
        buckets = new List<HashTableNode>*[numBuckets] {nullptr};
    }
    
    ~HashTable() 
    {
        eraseAll();
    }
    
    void setValueForKey(Key key, Value value)
    {
        int hashIndex = keyHash(key) % numBuckets;
        List<HashTableNode> *keyValueList = buckets[hashIndex];
        if (keyValueList == nullptr) {
            vector<HashTableNode> vect = {HashTableNode(key, value)};
            List<HashTableNode> *newList = new List<HashTableNode>(vect);
            buckets[hashIndex] = newList;
            count += 1;
        } else {
            auto it = keyValueList->begin();
            while (it != keyValueList->end()) {
                HashTableNode curNode = *it;
                if (keysEqual(curNode.key, key)) {
                    auto next = it;
                    next++;
                    keyValueList->removeAt(it);
                    keyValueList->insertAt(next, HashTableNode(key, value));
                    return;
                }
                it++;
            }
            keyValueList->insertAt(it, HashTableNode(key, value));
            count += 1;
        }
        rebalanceHashTableIfApplicable();
    }
    
    std::optional<Value> getValueForKey(Key key)
    {
        int hashIndex = keyHash(key) % numBuckets;
        List<HashTableNode> *keyValueList = buckets[hashIndex];
        if (keyValueList == nullptr) { return nullopt; }
        for (auto it = keyValueList->begin(); it != keyValueList->end(); it++) {
            HashTableNode curNode = *it;
            if (keysEqual(curNode.key, key)) { return curNode.value; }
        }
        return nullopt;
    }
    
    void removeValueForKey(Key key)
    {
        int hashIndex = keyHash(key) % numBuckets;
        List<HashTableNode> *keyValueList = buckets[hashIndex];
        if (keyValueList != nullptr) {
            for (auto it = keyValueList->begin(); it != keyValueList->end(); it++) {
                HashTableNode curNode = *it;
                if (keysEqual(curNode.key, key)) {
                    keyValueList->removeAt(it);
                    if (keyValueList->count == 0) {
                        buckets[hashIndex] = nullptr;
                    }
                    count -= 1;
                    return;
                }
            }
        }
    }
    
    void eraseAll() 
    {
        for (int i = 0; i < numBuckets; i++) {
            List<HashTableNode> *list = buckets[i];
            if (list != nullptr) { delete list; }
        }
        delete []buckets;
        count = 0;
    }
    
    /**
     * Method for debugging purposes that returns contents
     * of Hash Table along with the structure.
     */
    vector<vector<std::pair<Key, Value>>> getStructuredKeysAndValues() 
    {
        vector<vector<std::pair<Key, Value>>> result;
        for (int i = 0; i < numBuckets; i++) {
            List<HashTableNode> *currentList = buckets[i];
            vector<std::pair<Key, Value>> keysAndValues = {};
            if (currentList != nullptr) {
                for (auto it = currentList->begin(); it != currentList->end(); it++) {
                    keysAndValues.push_back(std::make_pair((*it).key, (*it).value));
                }
            }
            result.push_back(keysAndValues);
        }
        return result;
    }
    
};
