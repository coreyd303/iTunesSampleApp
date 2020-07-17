//
//  Genre.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct Genre: Codable, Equatable {
    let genreId: String
    let name: String
    let url: String
}
