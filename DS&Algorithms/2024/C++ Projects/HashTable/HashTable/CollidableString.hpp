//
//  CollidableString.hpp
//  HashTable
//
//  Created by Abhay Curam on 7/26/24.
//

#include <stdio.h>
#include <string>
#include <functional>

struct CollidableString {
public:
    std::string string;
    bool shouldCollideHash;
    CollidableString(std::string string, bool shouldCollideHash) : string(string), shouldCollideHash(shouldCollideHash) {}
};

template<>
struct std::hash<CollidableString> {
    std::size_t operator()(const CollidableString& s)
    {
        if (s.shouldCollideHash) { return 3467; }
        auto hash = std::hash<string>();
        return hash(s.string);
    }
};

template<>
struct std::equal_to<CollidableString> {
    const bool operator()(const CollidableString& lhs, const CollidableString& rhs)
    {
        return lhs.string == rhs.string;
    }
};
