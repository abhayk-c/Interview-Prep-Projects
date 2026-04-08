//
//  LRUCache.hpp
//  LRUCache
//
//  Created by Abhay Curam on 5/25/25.
//

#include <unordered_map>
#include <list>
#include <optional>

/**
 * A basic generic LRU Cache.
 * The LRU Cache "wraps"/"composes" std::unordered_map and std::list to
 * implement the LRU Cache data structure. There are wrappers using this cache
 * for EIP book solution and passing Leetcode solver.
 */
template <typename K, typename V>
class LRUCache {

private:
    struct LRUListCacheItem {
        K key;
        V value;
        LRUListCacheItem(K key, V value) : key(key), value(value) {}
    };
    std::list<LRUListCacheItem> list;
    std::unordered_map<K, typename std::list<LRUListCacheItem>::iterator> map;
    int capacity;
    int count;
    
    void evictEntriesIfNeeded() {
        if (count >= capacity) {
            auto list_it = list.rbegin();
            map.erase(list_it->key);
            list.pop_back();
            count--;
        }
    }
    
    void insertKeyAndValue(const K& key, const V& value) {
        LRUListCacheItem listItem = LRUListCacheItem(key, value);
        auto it = list.insert(list.begin(), listItem);
        map[key] = it;
        count++;
    }
    
    std::optional<V> removeValueForKey(const K& key, const bool shouldRemoveFromMap) {
        auto map_it = map.find(key);
        if (map_it != map.end()) {
            auto list_it = map_it->second;
            V value = list_it->value;
            list.erase(list_it);
            /*
             * This simple flag check sped up our code by 50% from only beating 10% of
             * leetcode submissions to beating 60%. Why? erasing the key and iterator value
             * from the hash map for the set() and get() cache API's is wasteful. We simply need
             * to update the iterator value at the key in the hash map if it exists. A simple
             * updateValue() is much faster than erase(<key, val>), and reinsert(<key, val>)
             * especially over many calls and large data. Without fixing/reserving the hashtable
             * capacity this can get even worse since erase and reinsert can cause the table to resize.
             */
            if (shouldRemoveFromMap) { map.erase(map_it); }
            count--;
            return value;
        }
        return std::nullopt;
    }
    
public:
    LRUCache(int cacheCapacity) {
        capacity = cacheCapacity;
        count = 0;
        list = std::list<LRUListCacheItem>();
        map = std::unordered_map<K, typename std::list<LRUListCacheItem>::iterator>();
        /**
         * Since we already know the cacheCapacity we can fix the size of our hashtable.
         * This reserves enough space to hold the max number of cache elements we are expecting
         * and avoids costly resizes as we insert elements into our hash table.
         * Just setting the size sped up our code by 15% in leetcode.
         */
        map.reserve(cacheCapacity);
    }
    
    void setValueForKey(const K& key, const V& value) {
        removeValueForKey(key, false);
        evictEntriesIfNeeded();
        insertKeyAndValue(key, value);
    }
    
    std::optional<V> getValueForKey(const K& key) {
        auto foundAndRemovedValue = removeValueForKey(key, false);
        if (foundAndRemovedValue.has_value()) {
            insertKeyAndValue(key, foundAndRemovedValue.value());
            return foundAndRemovedValue.value();
        }
        return std::nullopt;
    }
    
    std::optional<V> removeValueForKey(const K& key) {
        return removeValueForKey(key, true);
    }
    
    int getCount() { return count; }
    int getCapacity() { return capacity; }
};

