//
//  Cocktail.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import Foundation

struct Cocktail: Decodable, Identifiable {
    let id: String
    let name: String
    let imageUrl: String
}
