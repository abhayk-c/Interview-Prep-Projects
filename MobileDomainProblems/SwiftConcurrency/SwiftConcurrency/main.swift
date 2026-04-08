//
//  main.swift
//  SwiftConcurrency
//
//  Created by Abhay Curam on 11/14/25.
//

import Foundation
import Dispatch

let homeAddress = Address(city: "San Jose", streetAddress: "3381 Bel Mira Way", state: "CA", country: "USA", zipCode: 95135, countryCode: 1)
let homeAddress2 = Address(city: "San Francisco", streetAddress: "623 Minna Street", state: "CA", country: "USA", zipCode: 95103, countryCode: 1)

let abhayContact = ContactInfo(firstName: "Abhay", lastName: "Curam", age: 33, emailAddresses: ["abhaycuram@gmail.com", "aceklay91@gmail.com"], addresses: [homeAddress, homeAddress2])
let ajayContact = ContactInfo(firstName: "Ajay", lastName: "Curam", age: 28, emailAddresses: ["ajaycuram@gmail.com"], addresses: [homeAddress])

let abhayContactData = try JSONEncoder().encode(abhayContact)
let ajayContactData = try JSONEncoder().encode(ajayContact)

let storageDirectoryString = "/Users/abhaycuram/Desktop/KeyValueStoreActorCache"
let url = URL(fileURLWithPath: storageDirectoryString)
let storageLocation = KeyValueStorageLocation(storageDirectoryURL: url, storageDirectoryPathString: storageDirectoryString)
let keyValueStore = KeyValueStoreActor(storageLocation)

Task {
    print("Simulated UI Layout Task executing on Main Thread")
}

print("Before writing Key Value Data to Disk")
async let writeResultOne = keyValueStore.setValueForKey("abhay_contact_3.json", abhayContactData)
async let writeResultTwo = keyValueStore.setValueForKey("ajay_contact_4.json", ajayContactData)
print("Finished Writing Key Value Data to Disk")

Task {
    print("Simulated UI Animation Task executing on Main Thread")
}

print("Before removing Key Value Data from Disk")
async let removeResultOne = keyValueStore.removeValueForKey("abhay_contact_1.json")
async let removeResultTwo = keyValueStore.removeValueForKey("ajay_contact_2.json")
print("Finished removing Key Value Data from Disk")

Task {
    print("Simulated UI Animation 2 Task executing on Main Thread")
}

print("Before reading Key Value Data from disk.")
let readResultOne = try await keyValueStore.getValueForKey("abhay_contact.json")
let readResultTwo = try await keyValueStore.getValueForKey("ajay_contact.json")
let abhayContactInfo = try JSONDecoder().decode(ContactInfo.self, from: readResultOne.data!)
let ajayContactInfo = try JSONDecoder().decode(ContactInfo.self, from: readResultTwo.data!)
print(abhayContactInfo)
print(ajayContactInfo)
print("After reading Key Value Data from disk.")

/*keyValueStore.setValueForKey("abhay-contact.json", abhayContactData) { result, error in
    if result.didSucceed {
        print("Successfully wrote to disk: \(result.key)")
    } else if let writeError = error as? NSError {
        print("Failed to write to disk: \(result.key), with Error: \(writeError.localizedDescription)")
    }
}
keyValueStore.setValueForKey("ajay-contact.json", ajayContactData) { result, error in
    if result.didSucceed {
        print("Successfully wrote to disk: \(result.key)")
    } else if let writeError = error as? NSError {
        print("Failed to write to disk: \(result.key), with Error: \(writeError.localizedDescription)")
    }
}

keyValueStore.getValueForKey("abhay-contact.json") { result, error in
    if let data = result.data {
        print("Successfully read from disk: \(result.key)")
        do {
            let decodedModel = try JSONDecoder().decode(ContactInfo.self, from: data)
            print(decodedModel)
        } catch {
            print("Failed to read from disk: \(result.key), with Error: \(error.localizedDescription)")
        }
    } else {
        print("Failed to read from disk: \(result.key), with Error: \(error?.localizedDescription ?? "")")
    }
}

keyValueStore.getValueForKey("ajay-contact.json") { result, error in
    if let data = result.data {
        print("Successfully read from disk: \(result.key)")
        do {
            let decodedModel = try JSONDecoder().decode(ContactInfo.self, from: data)
            print(decodedModel)
        } catch {
            print("Failed to read from disk: \(result.key), with Error: \(error.localizedDescription)")
        }
    } else {
        print("Failed to read from disk: \(result.key), with Error: \(error?.localizedDescription ?? "")")
    }
}

keyValueStore.getValueForKey("ajays-contact.json") { result, error in
    if let data = result.data {
        print("Successfully read from disk: \(result.key)")
        do {
            let decodedModel = try JSONDecoder().decode(ContactInfo.self, from: data)
            print(decodedModel)
        } catch {
            print("Failed to read from disk: \(result.key), with Error: \(error.localizedDescription)")
        }
    } else {
        print("Failed to read from disk: \(result.key), with Error: \(error?.localizedDescription ?? "")")
    }
}

keyValueStore.removeValueForKey("abhays-contact") { result, error in
    if result.didSucceed {
        print("Successfully removed from disk: \(result.key)")
    } else if let removeError = error as? NSError {
        print("Failed to remove from disk: \(result.key), with Error: \(removeError.localizedDescription)")
    }
}

keyValueStore.removeValueForKey("ajay-contact") { result, error in
    if result.didSucceed {
        print("Successfully removed from disk: \(result.key)")
    } else if let removeError = error as? NSError {
        print("Failed to remove from disk: \(result.key), with Error: \(removeError.localizedDescription)")
    }
}

keyValueStore.removeValueForKey("abhay-contact") { result, error in
    if result.didSucceed {
        print("Successfully removed from disk: \(result.key)")
    } else if let removeError = error as? NSError {
        print("Failed to remove from disk: \(result.key), with Error: \(removeError.localizedDescription)")
    }
}
*/
