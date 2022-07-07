//
//  CocktailsEndpoint.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import Foundation

enum CocktailsEndpoint {
    case allCocktails
    case cocktail(_: String)
}

extension CocktailsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .allCocktails:
            return "cocktails"
        case .cocktail(let id):
            return "cocktails/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allCocktails, .cocktail:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .allCocktails, .cocktail:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .allCocktails, .cocktail:
            return nil
        }
    }
}
