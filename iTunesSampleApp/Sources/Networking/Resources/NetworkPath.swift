//
//  NetworkPath.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

enum NetworkPath: CustomStringConvertible {
    case getMusic(feedType: String, genre: String, limit: Int, allowExplicit: Bool)

    var description: String {
        switch self {
        case .getMusic(let feedType, let genre, let limit, let allowExplicit):
            return "/\(feedType)/\(genre)/\(limit)/\(allowExplicit).json"
        }
    }
}
