//
//  Contact.hpp
//  HashTable
//
//  Created by Abhay Curam on 7/28/24.
//

#include <stdio.h>
#include <string>
#include <functional>

/**
 * This is literally just taken from the boost library directly.
 * In an interview setting or real project use hash_combine from boost.
 */
namespace boost {
template <class T>
inline void hash_combine(std::size_t& seed, const T& v)
{
    std::hash<T> hasher;
    seed ^= hasher(v) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
}
}

/**
 * Example of a custom hashable type in C++ that combines
 * hash values correctly.
 */
struct Contact {
    std::string firstName;
    std::string lastName;
    Contact(std::string firstName, std::string lastName) : firstName(firstName), lastName(lastName) {}
};

template<>
struct std::hash<Contact> {
    std::size_t operator()(const Contact& c)
    {
        std::hash<string> hash;
        std::size_t seed = 0;
        /**
         * To combine hash codes we can simply use boost::hash-combine()
         * This does the equivalent of a bitwise XOR with some additional ops.
         */
        boost::hash_combine(seed, hash(c.firstName));
        boost::hash_combine(seed, hash(c.lastName));
        return seed;
    }
};

template<>
struct std::equal_to<Contact> {
    bool operator()(const Contact& lhs, const Contact& rhs)
    {
        return (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName);
    }
};


