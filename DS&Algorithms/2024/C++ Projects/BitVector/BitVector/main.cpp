//
//  main.cpp
//  BitVector
//
//  Created by Abhay Curam on 7/16/24.
//

#include <iostream>

/**
 * This creates a BitVector which is the same concept as the C++
 * bitset data structure. This creates a very terse and compact data
 * structure. To the client it feels like an array of bit's with a boolean
 * true/false indicating whether the bit at a specific position is off or on.
 * In other words a table where bit positions are the key, and value is flag
 * indicating whether the bit is set. It can also be thought of as a very large bitmask.
 */
class BitVector {
    
private:
    char *bytes;
    int size;
    
public:
    BitVector(int size) {
        int capacity = size / 8;
        if (size % 8 > 0) { capacity += 1; }
        bytes = new char[capacity];
        size = size;
    }
    
    ~BitVector() {
        delete[] bytes;
    }
    
    void set(bool value, int pos) {
        if (pos < size) {
            const int byteArrayIndex = (pos / 8);
            const int bitPos = (pos % 8);
            if (value) {
                char byte = bytes[byteArrayIndex];
                byte = byte | (1 << bitPos);
                bytes[byteArrayIndex] = byte;
            } else {
                char byte = bytes[byteArrayIndex];
                byte &= ~(1 << bitPos);
                bytes[byteArrayIndex] = byte;
            }
        }
    }
    
    bool get(int pos) {
        if (pos < size) {
            const int byteArrayIndex = (pos / 8);
            const int bitPos = (pos % 8);
            return (bytes[byteArrayIndex] & (1 << bitPos));
        }
        return false;
    }
};


int main(int argc, const char * argv[]) {
    std::cout << "================" << std::endl;
    BitVector twentyBitVector = BitVector(20);
    twentyBitVector.set(true, 19);
    twentyBitVector.set(true, 17);
    twentyBitVector.set(true, 5);
    twentyBitVector.set(true, 3);
    twentyBitVector.set(false, 5);
    twentyBitVector.set(false, 5);
    std::cout << "bit value at 0: " << twentyBitVector.get(0) << std::endl;
    std::cout << "bit value at 1: " << twentyBitVector.get(1) << std::endl;
    std::cout << "bit value at 2: " << twentyBitVector.get(2) << std::endl;
    std::cout << "bit value at 3: " << twentyBitVector.get(3) << std::endl;
    std::cout << "bit value at 4: " << twentyBitVector.get(4) << std::endl;
    std::cout << "bit value at 5: " << twentyBitVector.get(5) << std::endl;
    std::cout << "bit value at 6: " << twentyBitVector.get(6) << std::endl;
    std::cout << "bit value at 7: " << twentyBitVector.get(7) << std::endl;
    std::cout << "bit value at 8: " << twentyBitVector.get(8) << std::endl;
    std::cout << "bit value at 9: " << twentyBitVector.get(9) << std::endl;
    std::cout << "bit value at 10: " << twentyBitVector.get(10) << std::endl;
    std::cout << "bit value at 11: " << twentyBitVector.get(11) << std::endl;
    std::cout << "bit value at 12: " << twentyBitVector.get(12) << std::endl;
    std::cout << "bit value at 13: " << twentyBitVector.get(13) << std::endl;
    std::cout << "bit value at 14: " << twentyBitVector.get(14) << std::endl;
    std::cout << "bit value at 15: " << twentyBitVector.get(15) << std::endl;
    std::cout << "bit value at 16: " << twentyBitVector.get(16) << std::endl;
    std::cout << "bit value at 17: " << twentyBitVector.get(17) << std::endl;
    std::cout << "bit value at 18: " << twentyBitVector.get(18) << std::endl;
    std::cout << "bit value at 19: " << twentyBitVector.get(19) << std::endl;
    std::cout << "bit value at 20: " << twentyBitVector.get(20) << std::endl;
}
