//
//  CachedImageView.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

class CachedImageView: UIImageView {

    // MARK: - Properties

    var imageCache: ImageCache = ImageCacheImplementation()

    // MARK: - Public

    /// loads an image either from cache or request
    /// - Parameter url: a url for the image
    func setImage(_ url: URL) {
        imageCache.loadImage(with: url) { [weak self] (image) in
            self?.image = image
        }
    }
}
