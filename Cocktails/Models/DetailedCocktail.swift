//
//  DetailedCocktail.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import Foundation

struct DetailedCocktail: Decodable, Identifiable {
    let id: String
    let name: String
    let imageUrl: String
    let glass: String
    let instructions: String
    let ingredients: [Ingredient]
}
