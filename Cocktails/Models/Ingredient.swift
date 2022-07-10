//
//  Ingredient.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import Foundation

struct Ingredient: Decodable, Hashable {
    let name: String
    let measure: String?
}
