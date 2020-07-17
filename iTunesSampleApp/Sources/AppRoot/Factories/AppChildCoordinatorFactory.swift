//
//  AppChildCoordinatorFactory.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol AppChildCoordinatorFactory: class {
    func makeStartupCoordinator() -> StartupCoordinator
    func makeMusicFeedCoordinator() -> MusicFeedCoordinator
}

class AppChildCoordinatorFactoryImplementation: AppChildCoordinatorFactory {

    // MARK: - Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Public

    /// create an instance of the requested coordinaotr
    /// - Returns: a StartupCoordinator
    func makeStartupCoordinator() -> StartupCoordinator {
        let dispatcher = NetworkDispatcherImplementation()
        let requestFactory = MusicServiceRequestFactoryImplementation()
        let musicService = MusicServiceImplementation(dispatcher: dispatcher, requestFactory: requestFactory)

        let imageCache = ImageCacheImplementation()

        return StarupCoordinatorImplementation(musicService: musicService, imageCache: imageCache)
    }

    /// create an instance of requested coordinator
    /// - Returns: a MusicFeedCoordinator
    func makeMusicFeedCoordinator() -> MusicFeedCoordinator {
        let presentableFactory = MusicFeedPresentableFactoryImplementation()
        let childFactory = MusicFeedChildCoordinatorFactoryImplementation(router: router)

        return MusicFeedCoordinatorImplementation(router: router, presentableFactory: presentableFactory, childFactory: childFactory)
    }
}
