//
//  DogResponse.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

struct DogResponse: Codable, Identifiable, Hashable {
    let weight: [String: String]
    let height: [String: String]
    let id: Int
    let name: String
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String?
    let temperament: String
    let origin: String?
    let referenceImageId: String

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    enum CodingKeys: String, CodingKey {
        case weight
        case height
        case id
        case name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament
        case origin
        case referenceImageId = "reference_image_id"
    }
}
