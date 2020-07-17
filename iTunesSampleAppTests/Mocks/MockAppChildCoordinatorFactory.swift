//
//  MockAppChildCoordinatorFactory.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

class MockAppChildCoordinatorFactory: AppChildCoordinatorFactory {
    var invokedMakeStartupCoordinator = false
    var invokedMakeStartupCoordinatorCount = 0
    var stubbedMakeStartupCoordinatorResult: StartupCoordinator!
    func makeStartupCoordinator() -> StartupCoordinator {
        invokedMakeStartupCoordinator = true
        invokedMakeStartupCoordinatorCount += 1
        return stubbedMakeStartupCoordinatorResult
    }
    var invokedMakeMusicFeedCoordinator = false
    var invokedMakeMusicFeedCoordinatorCount = 0
    var stubbedMakeMusicFeedCoordinatorResult: MusicFeedCoordinator!
    func makeMusicFeedCoordinator() -> MusicFeedCoordinator {
        invokedMakeMusicFeedCoordinator = true
        invokedMakeMusicFeedCoordinatorCount += 1
        return stubbedMakeMusicFeedCoordinatorResult
    }
}
