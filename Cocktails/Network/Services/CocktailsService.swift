//
//  CocktailsService.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import Foundation

protocol CocktailsServiceable {
    func getCocktails() async throws -> [Cocktail]
}

struct CocktailsService: HTTPClient, CocktailsServiceable {
    func getCocktails() async throws -> [Cocktail] {
        try await sendJsonRequest(endpoint: CocktailsEndpoint.allCocktails, responseModel: [Cocktail].self)
    }
    
    func getDetailedCocktail(withID id: String) async throws -> DetailedCocktail {
        try await sendJsonRequest(endpoint: CocktailsEndpoint.cocktail(id), responseModel: DetailedCocktail.self)
    }
}
