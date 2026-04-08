//
//  LeetcodeLRUCache.hpp
//  LRUCache
//
//  Created by Abhay Curam on 5/25/25.
//

#import "LRUCache.hpp"

/*
 * Wrapper for the Leetcode Cache.
 * Leetcode just wants a integer lru cache.
 * https://leetcode.com/problems/lru-cache/description/
 */
class LeetcodeLRUCache {
public:
    LeetcodeLRUCache(int capacity) : cache(LRUCache<int, int>(capacity)) {}
    
    int get(int key) {
        return cache.getValueForKey(key).value_or(-1);
    }
    
    void put(int key, int value) {
        cache.setValueForKey(key, value);
    }

private:
    LRUCache<int, int> cache;
};

