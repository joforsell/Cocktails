//
//  RequestError.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "There was an error decoding the request."
        case .noResponse:
            return "There was no response from the server. It may be temporarily offline."
        case .unexpectedStatusCode:
            return "Something went wrong when fetching the request."
        case .unauthorized:
            return "Your session has expired."
        default:
            return "Unknown error."
        }
    }
}
