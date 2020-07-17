//
//  MusicFeedChildCoordinatorFactory.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol MusicFeedChildCoordinatorFactory: class {
    func makeAlbumDetailCoordinator() -> AlbumDetailsCoordinator
}

class MusicFeedChildCoordinatorFactoryImplementation: MusicFeedChildCoordinatorFactory {

    // MARK: - Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Public

    /// create an instance of the requested coordinator
    /// - Returns: an instance of AlbumDetailsCoordinator
    func makeAlbumDetailCoordinator() -> AlbumDetailsCoordinator {
        let presentableFactory = AlbumDetailsPresentableFactoryImplementation()
        let childFactory = AlbumDetailsChildCoordinatorFactoryImplementation()

        return AlbumDetailsCoordinatorImplementation(router: router, presentableFactory: presentableFactory, childCoordinatorFactory: childFactory)
    }
}
