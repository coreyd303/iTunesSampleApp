//
//  BaseCoordinator.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

class BaseCoordinator: NSObject, Coordinator {

    // MARK: - Properties

    var childCoordinators: [Coordinator] = []

    // MARK: - Public

    /// Force subclassed implementation of start
    func start() {
        fatalError("BaseCoordinator must be subclassed")
    }

    /// cache dependent child coordinators
    /// - Parameter coordinator: child coordinator to be placed in cache
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator}) else { return }
        childCoordinators.append(coordinator)
    }

    /// remove chached child coordinator
    /// - Parameter coordinator: child coordinator to be removed from cache
    func removeDependency(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty, let coordinator = coordinator else { return }
        if let coordinator = coordinator as? BaseCoordinator {
            if !coordinator.childCoordinators.isEmpty {
                coordinator.childCoordinators.filter({ $0 !== coordinator }).forEach({ coordinator.removeDependency($0) })
            }

        }

        for(index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
