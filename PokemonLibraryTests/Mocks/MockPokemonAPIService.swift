//
//  MockPokemonAPIService.swift
//  PokemonLibraryTests
//
//  Created by Tiago Antunes on 03/03/2024.
//

import Combine
import Foundation
@testable import PokemonLibrary

final class MockPokemonAPIService: APIServiceType {
    var stubs: [Any] = []
    internal let session = URLSession.shared
    internal let bgQueue = DispatchQueue(label: "test")

    func stub<Request>(
        for type: Request.Type,
        response: @escaping ((Request) -> AnyPublisher<Request.ModelType, Error>)
    )
    where Request: APIRequestType {
        stubs.append(response)
    }

    func call<Request>(from request: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType {

        let response = stubs.compactMap { stub -> AnyPublisher<Request.ModelType, Error>? in
            let stub = stub as? ((Request) -> AnyPublisher<Request.ModelType, Error>)
            return stub?(request)
        }.last

        return response ?? Empty<Request.ModelType, Error>()
            .eraseToAnyPublisher()
    }
}
