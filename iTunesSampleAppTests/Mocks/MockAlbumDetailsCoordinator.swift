//
//  MockAlbumDetailsCoordinator.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

class MockAlbumDetailsCoordinator: AlbumDetailsCoordinator {
    var invokedDidFinishSetter = false
    var invokedDidFinishSetterCount = 0
    var invokedDidFinish: (() -> ())?
    var invokedDidFinishList = [(() -> ())?]()
    var invokedDidFinishGetter = false
    var invokedDidFinishGetterCount = 0
    var stubbedDidFinish: (() -> ())!
    var didFinish: (() -> ())? {
        set {
            invokedDidFinishSetter = true
            invokedDidFinishSetterCount += 1
            invokedDidFinish = newValue
            invokedDidFinishList.append(newValue)
        }
        get {
            invokedDidFinishGetter = true
            invokedDidFinishGetterCount += 1
            return stubbedDidFinish
        }
    }
    var invokedStartWith = false
    var invokedStartWithCount = 0
    var invokedStartWithParameters: (album: Album, Void)?
    var invokedStartWithParametersList = [(album: Album, Void)]()
    func start(with album: Album) {
        invokedStartWith = true
        invokedStartWithCount += 1
        invokedStartWithParameters = (album, ())
        invokedStartWithParametersList.append((album, ()))
    }
    var invokedStart = false
    var invokedStartCount = 0
    func start() {
        invokedStart = true
        invokedStartCount += 1
    }
}
