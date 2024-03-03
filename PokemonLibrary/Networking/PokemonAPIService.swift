//
//  PokemonAPIService.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 03/03/2024.
//

import Combine
import Foundation

protocol APIServiceType {
    var session: URLSession {get}
    var bgQueue: DispatchQueue {get}
    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType
}

final class PokemonAPIService: APIServiceType {

    internal let session = URLSession.shared
    internal let bgQueue = DispatchQueue.main

    func call<Request>(from endpoint: Request) -> AnyPublisher<Request.ModelType, Error> where Request: APIRequestType {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let request = try endpoint.buildRequest()
            return session.dataTaskPublisher(for: request)
                .retry(1)
                .tryMap {
                    guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                        throw APIServiceError.unexpectedResponse
                    }
                    guard HTTPCodes.success.contains(code) else {
                        throw APIServiceError.httpError(code)
                    }
                    return $0.data // Pass data to downstream publishers
                }
                .decode(type: Request.ModelType.self, decoder: decoder)
                .mapError {_ in APIServiceError.parseError}
                .receive(on: self.bgQueue)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Request.ModelType, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
