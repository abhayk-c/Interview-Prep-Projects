//
//  ISBNCache.hpp
//  LRUCache
//
//  Created by Abhay Curam on 5/25/25.
//

#include <string>
#include <optional>
#import "LRUCache.hpp"

/*
 * Problem 12.3 in Elements of Programming Interviews!
 */
class ISBNCache {

public:
    
    ISBNCache(int capacity) : cache(LRUCache<std::string, float>(capacity)) {}
    
    void setPriceForISBN(const std::string& isbn, const float& price)
    {
        cache.setValueForKey(isbn, price);
    }
    
    std::optional<float> getPriceForISBN(const std::string& isbn)
    {
        return cache.getValueForKey(isbn);
    }
    
    void removePriceForISBN(const std::string& isbn)
    {
        cache.removeValueForKey(isbn);
    }
    
    
private:
    LRUCache<std::string, float> cache;
};
