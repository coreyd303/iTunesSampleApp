//
//  AppChildCoordinatorFactory.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol AppChildCoordinatorFactory: class {
    func makeStartupCoordinator() -> StartupCoordinator
    func makeMessageFeedCoordinator() -> MessageFeedCoordinator
}

class AppChildCoordinatorFactoryImplementation: AppChildCoordinatorFactory {

    // MARK: - Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    // MARK: - Public

    /// create and instance of requested coordinator
    /// - Returns: a StartupCoordinator
    func makeStartupCoordinator() -> StartupCoordinator {
        let dispatcher = NetworkDispatcherImplementation()
        let requestFactory = MessageServiceRequestFactoryImplementation()
        let messageService = MessageServiceImplementation(dispatcher: dispatcher, requestFactory: requestFactory)

        return StarupCoordinatorImplementation(messageService: messageService)
    }

    /// create an instance of requested coordinator
    /// - Returns: a MessageFeedCoordinator
    func makeMessageFeedCoordinator() -> MessageFeedCoordinator {
        let childFactory = MessageFeedChildCoordinatorFactoryImplementation(router: router)

        let userService = UserServiceImplementation()
        let presentableFactory = MessageFeedPresentableFactoryImplementation(userService: userService)

        return MessageFeedCoordinatorImplementation(router: router, presentableFactory: presentableFactory, childFactory: childFactory)
    }
}
