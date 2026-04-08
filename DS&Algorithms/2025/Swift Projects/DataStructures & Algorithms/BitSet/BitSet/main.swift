//
//  main.swift
//  BitSet
//
//  Created by Abhay Curam on 9/30/25.
//

import Foundation

print("Hello, World!")

var bitSet = BitSet(19)
print("Test 1: ")
print(bitSet[0])
print(bitSet[18])
bitSet[0] = true
bitSet[18] = true
print(bitSet[0])
print(bitSet[18])

print("Test 2:")
print(bitSet[0])
print(bitSet[2])
print(bitSet[7])
print(bitSet[18])
bitSet[2] = true
bitSet[7] = true
print(bitSet[0])
print(bitSet[2])
print(bitSet[7])
print(bitSet[18])

print("Test 3:")
print(bitSet[0])
print(bitSet[2])
print(bitSet[7])
print(bitSet[18])
bitSet[2] = false
bitSet[7] = true
print(bitSet[0])
print(bitSet[2])
print(bitSet[7])
print(bitSet[18])

print("Test 4:")
print(bitSet[0])
print(bitSet[2])
print(bitSet[7])
print(bitSet[18])
bitSet[0] = false
bitSet[2] = false
bitSet[7] = false
bitSet[13] = false
bitSet[18] = false
print(bitSet[0])
print(bitSet[2])
print(bitSet[7])
print(bitSet[13])
print(bitSet[18])

print("Test 5: ")
print(bitSet[-1])
print(bitSet[19])
bitSet[23] = false

