//
//  Error+Extensions.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

enum NetworkingError: Error, CustomStringConvertible, LocalizedError {
    case invalidURL
    case invalidResponse
    case testing
    case network(Error)
    case parsing(Error)

    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "The response is invalid."
        case .testing:
            return "Testing failed "
        case .network(let error):
            return "Network error: \(error.localizedDescription)"
        case .parsing(let error):
            return "Parsing error: \(error.localizedDescription)"
        }
    }

    var errorDescription: String? {
        return NSLocalizedString(self.description, comment: self.description)
    }
}

extension HTTPURLResponse {
    var isResponseOK: Bool {
        return (200..<299).contains(statusCode)
    }
}
