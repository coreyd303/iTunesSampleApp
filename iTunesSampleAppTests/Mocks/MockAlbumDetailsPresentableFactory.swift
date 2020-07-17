//
//  MockAlbumDetailsPresentableFactory.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

class MockAlbumDetailsPresentableFactory: AlbumDetailsPresentableFactory {
    var invokedMakeAlbumDetailsPresentable = false
    var invokedMakeAlbumDetailsPresentableCount = 0
    var stubbedMakeAlbumDetailsPresentableResult: AlbumDetailsPresentable!
    func makeAlbumDetailsPresentable() -> AlbumDetailsPresentable {
        invokedMakeAlbumDetailsPresentable = true
        invokedMakeAlbumDetailsPresentableCount += 1
        return stubbedMakeAlbumDetailsPresentableResult
    }
    var invokedMakeAlbumDetailsViewModel = false
    var invokedMakeAlbumDetailsViewModelCount = 0
    var invokedMakeAlbumDetailsViewModelParameters: (album: Album, Void)?
    var invokedMakeAlbumDetailsViewModelParametersList = [(album: Album, Void)]()
    var stubbedMakeAlbumDetailsViewModelResult: AlbumDetailsViewModel!
    func makeAlbumDetailsViewModel(album: Album) -> AlbumDetailsViewModel {
        invokedMakeAlbumDetailsViewModel = true
        invokedMakeAlbumDetailsViewModelCount += 1
        invokedMakeAlbumDetailsViewModelParameters = (album, ())
        invokedMakeAlbumDetailsViewModelParametersList.append((album, ()))
        return stubbedMakeAlbumDetailsViewModelResult
    }
}
