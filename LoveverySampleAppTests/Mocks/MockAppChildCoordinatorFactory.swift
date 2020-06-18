//
//  MockAppChildCoordinatorFactory.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockAppChildCoordinatorFactory: AppChildCoordinatorFactory {
    var invokedMakeStartupCoordinator = false
    var invokedMakeStartupCoordinatorCount = 0
    var stubbedMakeStartupCoordinatorResult: StartupCoordinator!
    func makeStartupCoordinator() -> StartupCoordinator {
        invokedMakeStartupCoordinator = true
        invokedMakeStartupCoordinatorCount += 1
        return stubbedMakeStartupCoordinatorResult
    }
    var invokedMakeMessageFeedCoordinator = false
    var invokedMakeMessageFeedCoordinatorCount = 0
    var stubbedMakeMessageFeedCoordinatorResult: MessageFeedCoordinator!
    func makeMessageFeedCoordinator() -> MessageFeedCoordinator {
        invokedMakeMessageFeedCoordinator = true
        invokedMakeMessageFeedCoordinatorCount += 1
        return stubbedMakeMessageFeedCoordinatorResult
    }
}
