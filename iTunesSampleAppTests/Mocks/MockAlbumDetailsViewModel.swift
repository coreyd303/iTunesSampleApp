//
//  MockAlbumDetailsViewModel.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

class MockAlbumDetailsViewModel: AlbumDetailsViewModel {
    var invokedAlbumGetter = false
    var invokedAlbumGetterCount = 0
    var stubbedAlbum: Album!
    var album: Album? {
        invokedAlbumGetter = true
        invokedAlbumGetterCount += 1
        return stubbedAlbum
    }
    var invokedItunesURLGetter = false
    var invokedItunesURLGetterCount = 0
    var stubbedItunesURL: String!
    var itunesURL: String? {
        invokedItunesURLGetter = true
        invokedItunesURLGetterCount += 1
        return stubbedItunesURL
    }
}
