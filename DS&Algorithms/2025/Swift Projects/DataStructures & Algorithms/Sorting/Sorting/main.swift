//
//  main.swift
//  Sorting
//
//  Created by Abhay Curam on 6/10/25.
//

import Foundation
var emptyArray: [String] = ["hi", ""]
print(mergeSort(emptyArray, .ascending))
let range = 0...2
let arrayOne = [8, 2, 7, 3, 7, 7, 5, 3, 6, 8]
let arrayTwo = [-4, -2, -2, -2, -1, -3, -3, -3]
let arrayThree = [50000, -33333, 4, 8, 2, 0, -50000, -50000, 8, 6, 49000]
print(sortArrayWithCountingSort(arrayOne))
print(sortArrayWithCountingSort(arrayTwo))
print(sortArrayWithRadixSort(arrayThree))

var dummyArray = [8, 2, 7, 3, 7, 7, 5, 3, 6, 8]
for i in (0..<dummyArray.count).reversed() {
    print(dummyArray[i])
}

//In-place sort of dummy array in ascending order
dummyArray.sort(by: <)
print(dummyArray) //[2, 3, 3, 5, 6, 7, 7, 7, 8, 8]
//In-place sort of dummy array in descending order
dummyArray.sort(by: >)
print(dummyArray) //[8, 8, 7, 7, 7, 6, 5, 3, 3, 2]
//Sorts that return a new array (not in-place)
let sortedAscending = dummyArray.sorted(by: <)
let sortedDescending = dummyArray.sorted(by: >)

typealias ContactRecord = (firstName: String, lastName: String)
var records: [ContactRecord] = [("Krishna", "Curam"), ("Ajay", "Curam"), ("Abhay", "Curam"), ("Padma", "Curam"), ("Bix", "Skywalker")]
//In-place "ascending" sort using a custom closure
records.sort(by: { return $0.firstName < $1.firstName })
//In-place "descending" sort using a custom closure
records.sort(by: { return $0.lastName > $1.lastName })

/**
 * Custom comparable type that can be sorted by all the API's above.
 */
struct Student: Comparable {
    let firstName: String
    let lastName: String
    let identifier: String
    
    //If you just define < this, Swift can synthesize the rest.
    static func < (lhs: Student, rhs: Student) -> Bool {
        return (lhs.firstName + lhs.lastName) < (rhs.firstName + rhs.lastName)
    }

    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.identifier == rhs.identifier
    }
}



