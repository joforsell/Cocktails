//
//  CocktailsServiceMock.swift
//  CocktailsTests
//
//  Created by Johan Forsell on 2022-07-12.
//

import Foundation
@testable import Cocktails

final class CocktailsServiceMock: Mockable, CocktailsServiceable {
    let jsonFileName: String
    
    init(jsonFileName: String = "cocktails_example") {
        self.jsonFileName = jsonFileName
    }
    
    func getCocktails() async throws -> [Cocktail] {
        return loadJSON(filename: jsonFileName, type: [Cocktail].self)
    }
    
    func getDetailedCocktail(withID id: String) async throws -> DetailedCocktail {
        return loadJSON(filename: jsonFileName, type: DetailedCocktail.self)
    }
}
