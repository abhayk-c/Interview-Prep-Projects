//
//  ContactInfo.swift
//  SwiftConcurrency
//
//  Created by Abhay Curam on 11/14/25.
//

public struct Address: Codable {
    let city: String
    let streetAddress: String
    let state: String
    let country: String
    let zipCode: Int
    let countryCode: Int
}

public struct ContactInfo: Codable {
    let firstName: String
    let lastName: String
    let age: Int
    let emailAddresses: [String]
    let addresses: [Address]
}
