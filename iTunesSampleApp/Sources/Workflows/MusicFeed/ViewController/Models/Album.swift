//
//  Album.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct Album: Codable, Equatable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl100: String
    let releaseDate: String
    let copyright: String
    let url: String
    let genres: [Genre]
}
