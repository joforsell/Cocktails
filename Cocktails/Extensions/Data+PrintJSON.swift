//
//  Data+PrintJSON.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-10.
//

import Foundation

extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print(JSONString)
        }
    }
}
