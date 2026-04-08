//
//  main.cpp
//  LRUCache
//
//  Created by Abhay Curam on 5/25/25.
//

#include <iostream>
#include <string>
#include "LRUCache.hpp"
#include "ISBNCache.hpp"
#include "LeetcodeLRUCache.hpp"

int main(int argc, const char * argv[]) {
    // insert code here...
    LRUCache<std::string, float> cache = LRUCache<std::string, float>(3);
    cache.setValueForKey("1234", 1.00);
    cache.setValueForKey("2345", 2.00);
    cache.setValueForKey("3456", 3.00);
    std::cout << "1234: " << cache.getValueForKey("1234").value_or(-1) << std::endl;
    std::cout << "2345: " << cache.getValueForKey("2345").value_or(-1) << std::endl;
    std::cout << "3456: " << cache.getValueForKey("3456").value_or(-1) << std::endl;
    std::cout << "count: " << cache.getCount() << std::endl;
    std::cout << "capacity: " << cache.getCapacity() << std::endl;
    cache.setValueForKey("4567", 4.00);
    std::cout << "1234: " << cache.getValueForKey("1234").value_or(-1) << std::endl;
    std::cout << "2345: " << cache.getValueForKey("2345").value_or(-1) << std::endl;
    std::cout << "3456: " << cache.getValueForKey("3456").value_or(-1) << std::endl;
    std::cout << "4567: " << cache.getValueForKey("4567").value_or(-1) << std::endl;
    std::cout << "count: " << cache.getCount() << std::endl;
    std::cout << "capacity: " << cache.getCapacity() << std::endl;
    cache.setValueForKey("2345", 10.50);
    cache.setValueForKey("5678", 30.00);
    std::cout << "1234: " << cache.getValueForKey("1234").value_or(-1) << std::endl;
    std::cout << "2345: " << cache.getValueForKey("2345").value_or(-1) << std::endl;
    std::cout << "3456: " << cache.getValueForKey("3456").value_or(-1) << std::endl;
    std::cout << "4567: " << cache.getValueForKey("4567").value_or(-1) << std::endl;
    std::cout << "5678: " << cache.getValueForKey("5678").value_or(-1) << std::endl;
    std::cout << "count: " << cache.getCount() << std::endl;
    std::cout << "capacity: " << cache.getCapacity() << std::endl;
    cache.removeValueForKey("1234");
    cache.removeValueForKey("2345");
    cache.removeValueForKey("3456");
    cache.removeValueForKey("4567");
    cache.removeValueForKey("5678");
    std::cout << "1234: " << cache.getValueForKey("1234").value_or(-1) << std::endl;
    std::cout << "2345: " << cache.getValueForKey("2345").value_or(-1) << std::endl;
    std::cout << "3456: " << cache.getValueForKey("3456").value_or(-1) << std::endl;
    std::cout << "4567: " << cache.getValueForKey("4567").value_or(-1) << std::endl;
    std::cout << "5678: " << cache.getValueForKey("5678").value_or(-1) << std::endl;
    std::cout << "count: " << cache.getCount() << std::endl;
    std::cout << "capacity: " << cache.getCapacity() << std::endl;
    cache.setValueForKey("1234", 1.00);
    cache.setValueForKey("2345", 2.00);
    std::cout << "1234: " << cache.getValueForKey("1234").value_or(-1) << std::endl;
    std::cout << "2345: " << cache.getValueForKey("2345").value_or(-1) << std::endl;
    std::cout << "3456: " << cache.getValueForKey("3456").value_or(-1) << std::endl;
    std::cout << "4567: " << cache.getValueForKey("4567").value_or(-1) << std::endl;
    std::cout << "5678: " << cache.getValueForKey("5678").value_or(-1) << std::endl;
    std::cout << "count: " << cache.getCount() << std::endl;
    std::cout << "capacity: " << cache.getCapacity() << std::endl;
    
    return 0;
}
