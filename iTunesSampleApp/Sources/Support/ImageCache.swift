//
//  ImageCache.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

protocol ImageCache: class {
    func loadImage(with url: URL, _ completion: ((UIImage) -> ())?)
}

class ImageCacheImplementation: ImageCache {

    // MARK: - Properties

    private let queue: Queue

    // MARK: - Initialization

    init(queue: Queue = Queue()) {
        self.queue = queue
    }

    // MARK: - Public

    /// request image from cache or url
    /// - Parameters:
    ///   - url: url for the image
    ///   - completion: async call back when done with image
    func loadImage(with url: URL, _ completion: ((UIImage) -> ())?) {
        if let cached = imageCache.object(forKey: url as AnyObject) as? UIImage {
            completion?(cached)
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            guard let data = data, error == nil else { return }

            self?.queue.main {
                if let cashable = UIImage(data: data) {
                    imageCache.setObject(cashable, forKey: url as AnyObject)
                    completion?(cashable)
                }
            }
        }).resume()
    }
}

