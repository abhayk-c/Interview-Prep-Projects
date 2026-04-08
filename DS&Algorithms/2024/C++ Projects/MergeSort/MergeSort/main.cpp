//
//  main.cpp
//  MergeSort
//
//  Created by Abhay Curam on 7/13/24.
//

#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include "MergeSort.hpp"
#include <functional>

void printIntVector(std::vector<int> intVector)
{
    for (int i = 0; i < intVector.size(); i++) {
        std::cout << intVector[i] << " ";
    }
    std::cout << std::endl;
}

int main(int argc, const char * argv[]) {
    
    std::vector<int> vec1 = {1, 2, 3, 4};
    std::vector<int> vec2 = {1, 2, 3, 4};
    std::vector<int> vec3 = {100};
    std::vector<int> vec4 = {-2};
    std::vector<int> vec5 = {};
    std::vector<int> vec6 = {4, 5, 6};
    std::vector<int> vec7 = {9, 10, 11, 11, 12};
    std::vector<int> vec8 = {11, 11};
    
    std::cout << "Let's perform a k-way merge: " << std::endl;
    std::vector<std::vector<int>> two_d_matrix = {vec1, vec2, vec3, vec4, vec5, vec6, vec7, vec8};
    printIntVector(kWayMerge(two_d_matrix));
    
    std::vector<int> sortedVectorEven = {1, 2, 3, 4};
    std::vector<int> sortedVectorOdd = {1, 2, 3};
    std::vector<int> singleElementVector = {1};
    std::vector<int> emptyVector = {};
    std::vector<int> unsortedVectorEven = {3, 4, 5, 0, 1, 2};
    std::vector<int> unsortedVectorOdd = {9, 1, 11, 2, -5, 100, 55, 77, 0};
    std::vector<int> unsortedVectorWithDuplicates = {9, 9, 9, 9, 9, 7, 7, 7, 3, 3, 3};
    
    std::cout << "Sorting: " << std::endl;
    printIntVector(sortIntegersIteratively(sortedVectorEven));
    printIntVector(sortIntegersIteratively(sortedVectorOdd));
    printIntVector(sortIntegersIteratively(singleElementVector));
    printIntVector(sortIntegersIteratively(emptyVector));
    printIntVector(sortIntegersIteratively(unsortedVectorEven));
    printIntVector(sortIntegersIteratively(unsortedVectorOdd));
    printIntVector(sortIntegersIteratively(unsortedVectorWithDuplicates));
    
    std::cout << "Sorting in place: " << std::endl;
    sortIntegersInPlace(sortedVectorEven);
    sortIntegersInPlace(sortedVectorOdd);
    sortIntegersInPlace(singleElementVector);
    sortIntegersInPlace(emptyVector);
    sortIntegersInPlace(unsortedVectorEven);
    sortIntegersInPlace(unsortedVectorOdd);
    sortIntegersInPlace(unsortedVectorWithDuplicates);
    printIntVector(sortedVectorEven);
    printIntVector(sortedVectorOdd);
    printIntVector(singleElementVector);
    printIntVector(emptyVector);
    printIntVector(unsortedVectorEven);
    printIntVector(unsortedVectorOdd);
    printIntVector(unsortedVectorWithDuplicates);
    
    /**
     * Ceil, Floor, and Rounding.
     * Only works with floats and doubles so have to cast
     * back to int if dealing with integers.
     */
    double pie = 3.14;
    float epsilon = 2.71;
    double ceilPie = ceil(pie);
    float floorEpsilon = floor(epsilon);
    double roundedPie = round(pie);
    double roundedEpsilon = round(epsilon);
    
    return 0;
}
