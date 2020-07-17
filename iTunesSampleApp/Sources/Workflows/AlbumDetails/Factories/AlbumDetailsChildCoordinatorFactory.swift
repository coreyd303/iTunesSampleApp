//
//  AlbumDetailsChildCoordinatorFactory.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol AlbumDetailsChildCoordinatorFactory: class {
    func makeItunesCoordinator(url: URL) -> ItunesAlbumCoordinator
}

class AlbumDetailsChildCoordinatorFactoryImplementation: AlbumDetailsChildCoordinatorFactory {

    // MARK: - Public

    /// create the requested coordinator
    /// - Parameter url: the reference URL for the coordinators start method
    /// - Returns: an instance of ItunesAlbumCoordinator
    func makeItunesCoordinator(url: URL) -> ItunesAlbumCoordinator {
        return ItunesAlbumCoordinatorImplementation(url: url)
    }
}
