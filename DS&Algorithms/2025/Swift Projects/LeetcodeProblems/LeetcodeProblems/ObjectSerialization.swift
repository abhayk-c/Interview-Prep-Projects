//
//  ObjectSerialization.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 11/28/25.
//

class Person {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    var friends: [Person]
    
    public init(_ firstName: String,
                _ lastName: String,
                _ phoneNumber: String,
                _ friends: [Person]) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.friends = friends
    }
    
    public func serializeToDictionary() -> [String : Any] {
        var recursiveVisitedSet: Set<ObjectIdentifier> = []
        return recursivelySerialize(&recursiveVisitedSet)
    }
    
    private func recursivelySerialize(_ recursiveVisitedSet: inout Set<ObjectIdentifier>) -> [String : Any] {
        let objectID = ObjectIdentifier(self)
        recursiveVisitedSet.insert(objectID)
        var currentDictionary: [String : Any] = [:]
        currentDictionary["firstName"] = firstName
        currentDictionary["lastName"] = lastName
        currentDictionary["phoneNumber"] = phoneNumber
        currentDictionary["objectID"] = String(UInt(bitPattern: objectID))
        var serializedFriends: [[String : Any]] = []
        for friend in friends {
            let friendObjectID = ObjectIdentifier(friend)
            var friendDictionary: [String : Any] = [:]
            if !recursiveVisitedSet.contains(friendObjectID) {
                friendDictionary = friend.recursivelySerialize(&recursiveVisitedSet)
            } else {
                friendDictionary["objectID"] = String(UInt(bitPattern: friendObjectID)) //only set the marker to avoid infinite recursion.
            }
            serializedFriends.append(friendDictionary)
        }
        
        currentDictionary["friends"] = serializedFriends
        return currentDictionary
    }
}
