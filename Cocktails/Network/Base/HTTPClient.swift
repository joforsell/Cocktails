//
//  HTTPClient.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import Foundation
import UIKit

protocol HTTPClient {
    func sendJsonRequest<T: Decodable>(endpoint: any Endpoint, responseModel: T.Type) async throws -> T
}

extension HTTPClient {
    func sendJsonRequest<T: Decodable>(endpoint: any Endpoint, responseModel: T.Type) async throws -> T {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw RequestError.decode
                }
                return decodedResponse
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            throw RequestError.unknown
        }
    }
}
