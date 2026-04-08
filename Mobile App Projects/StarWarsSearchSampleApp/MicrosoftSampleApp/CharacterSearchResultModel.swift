//
//  Untitled.swift
//  MicrosoftSampleApp
//
//  Created by Abhay Curam on 12/8/25.
//

public struct CharacterSearchResult: Codable {
    let result: [CharacterPropertiesContainer]
}

public struct CharacterPropertiesContainer: Codable {
    let properties: CharacterProperties
    let _id: String
    let description: String
    let __v: Int
    let uid: String
}

public struct CharacterProperties: Codable {
    let name: String
    let gender: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
}
