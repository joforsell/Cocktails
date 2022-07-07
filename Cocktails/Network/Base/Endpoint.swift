//
//  Endpoint.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "http://recruitmenttaskapi-env-1.eba-yxp4bns6.eu-west-2.elasticbeanstalk.com/"
    }
}
