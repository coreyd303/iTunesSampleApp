//
//  MockAlbumDetailsChildCoordinatorFactory.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

class MockAlbumDetailsChildCoordinatorFactory: AlbumDetailsChildCoordinatorFactory {
    var invokedMakeItunesCoordinator = false
    var invokedMakeItunesCoordinatorCount = 0
    var invokedMakeItunesCoordinatorParameters: (url: URL, Void)?
    var invokedMakeItunesCoordinatorParametersList = [(url: URL, Void)]()
    var stubbedMakeItunesCoordinatorResult: ItunesAlbumCoordinator!
    func makeItunesCoordinator(url: URL) -> ItunesAlbumCoordinator {
        invokedMakeItunesCoordinator = true
        invokedMakeItunesCoordinatorCount += 1
        invokedMakeItunesCoordinatorParameters = (url, ())
        invokedMakeItunesCoordinatorParametersList.append((url, ()))
        return stubbedMakeItunesCoordinatorResult
    }
}
