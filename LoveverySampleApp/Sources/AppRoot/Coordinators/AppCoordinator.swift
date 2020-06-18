//
//  AppCoordinator.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol AppCoordinator: Coordinator {
    var didFinish: (() -> ())? { get set }
}

class AppCoordinatorImplementation: BaseCoordinator, AppCoordinator {

    // MARK: - Properties

    var didFinish: (() -> ())?

    let window: WindowProviding
    let router: Router
    let childFactory: AppChildCoordinatorFactory

    var appState: AppState {
        didSet {
            if appState != .launching {
                self.present(appState)
            }
        }
    }

    // MARK: - Initialization

    init(window: WindowProviding, router: Router, childFactory: AppChildCoordinatorFactory, appState: AppState = .launching) {
        self.window = window
        self.router = router
        self.childFactory = childFactory
        self.appState = appState
    }

    // MARK: - Coordinator

    override func start() {
        window.setRootPresentable(router)
        present(appState)
    }

    // MARK: - Private

    /// present workflow based on the current appState
    /// - Parameter appState: the AppState to consider
    private func present(_ appState: AppState) {
        switch appState {
        case .launching:
            let childCoordinator = childFactory.makeStartupCoordinator()
            addDependency(childCoordinator)

            childCoordinator.didFinish = { [weak self] in
                self?.removeDependency(childCoordinator)
                self?.appState = .main
            }

            childCoordinator.start()
        case .main:
            let childCoordinator = childFactory.makeMessageFeedCoordinator()
            addDependency(childCoordinator)

            childCoordinator.didFinish = { [weak self] in
                self?.removeDependency(childCoordinator)
            }

            childCoordinator.start()
        }
    }
}
