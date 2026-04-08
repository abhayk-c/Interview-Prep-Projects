//
//  ConflictingEvents.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/22/25.
//

class ConflictingEvents {
    func haveConflict(_ event1: [String], _ event2: [String]) -> Bool {
        guard let event1Start = event1.first,
              let event1End = event1.last,
              let event2Start = event2.first,
              let event2End = event2.last else { return false }
        return (event2End >= event1Start && event2End <= event1End) || (event2Start <= event1End && event1End <= event2End)
    }
}
