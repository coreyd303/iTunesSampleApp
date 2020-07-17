//
//  StubAlbum.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

extension Album {
    static func stub(id: String = "",
                     name: String = "",
                     artistName: String = "",
                     artworkUrl100: String = "",
                     releaseDate: String = "",
                     copyright: String = "",
                     url: String = "",
                     genres: [Genre] = [Genre.stub()]) -> Album {

        return Album(id: id, name: name, artistName: artistName, artworkUrl100: artworkUrl100, releaseDate: releaseDate, copyright: copyright, url: url, genres: genres)
    }
}
