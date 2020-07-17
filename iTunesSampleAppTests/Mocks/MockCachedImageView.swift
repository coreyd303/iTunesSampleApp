//
//  MockCachedImageView.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import iTunesSampleApp

class MockCachedImageView: CachedImageView {
    var invokedImageCacheSetter = false
    var invokedImageCacheSetterCount = 0
    var invokedImageCache: ImageCache?
    var invokedImageCacheList = [ImageCache]()
    var invokedImageCacheGetter = false
    var invokedImageCacheGetterCount = 0
    var stubbedImageCache: ImageCache!
    override var imageCache: ImageCache {
        set {
            invokedImageCacheSetter = true
            invokedImageCacheSetterCount += 1
            invokedImageCache = newValue
            invokedImageCacheList.append(newValue)
        }
        get {
            invokedImageCacheGetter = true
            invokedImageCacheGetterCount += 1
            return stubbedImageCache
        }
    }
    var invokedSetImage = false
    var invokedSetImageCount = 0
    var invokedSetImageParameters: (url: URL, Void)?
    var invokedSetImageParametersList = [(url: URL, Void)]()
    override func setImage(_ url: URL) {
        invokedSetImage = true
        invokedSetImageCount += 1
        invokedSetImageParameters = (url, ())
        invokedSetImageParametersList.append((url, ()))
    }
}
