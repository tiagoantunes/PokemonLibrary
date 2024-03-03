//
//  HTTPMethod.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 03/03/2024.
//

import Foundation

public enum HTTPMethod: Equatable {
    case get
    case post
    case put
    case delete

    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
}
