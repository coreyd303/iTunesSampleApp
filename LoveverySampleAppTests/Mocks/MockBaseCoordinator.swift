//
//  MockBaseCoordinator.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockBaseCoordinator: BaseCoordinator {
    var invokedChildCoordinatorsSetter = false
    var invokedChildCoordinatorsSetterCount = 0
    var invokedChildCoordinators: [Coordinator]?
    var invokedChildCoordinatorsList = [[Coordinator]]()
    var invokedChildCoordinatorsGetter = false
    var invokedChildCoordinatorsGetterCount = 0
    var stubbedChildCoordinators: [Coordinator]! = []
    override var childCoordinators: [Coordinator] {
        set {
            invokedChildCoordinatorsSetter = true
            invokedChildCoordinatorsSetterCount += 1
            invokedChildCoordinators = newValue
            invokedChildCoordinatorsList.append(newValue)
        }
        get {
            invokedChildCoordinatorsGetter = true
            invokedChildCoordinatorsGetterCount += 1
            return stubbedChildCoordinators
        }
    }
    var invokedStart = false
    var invokedStartCount = 0
    override func start() {
        invokedStart = true
        invokedStartCount += 1
    }
    var invokedAddDependency = false
    var invokedAddDependencyCount = 0
    var invokedAddDependencyParameters: (coordinator: Coordinator, Void)?
    var invokedAddDependencyParametersList = [(coordinator: Coordinator, Void)]()
    override func addDependency(_ coordinator: Coordinator) {
        invokedAddDependency = true
        invokedAddDependencyCount += 1
        invokedAddDependencyParameters = (coordinator, ())
        invokedAddDependencyParametersList.append((coordinator, ()))
    }
    var invokedRemoveDependency = false
    var invokedRemoveDependencyCount = 0
    var invokedRemoveDependencyParameters: (coordinator: Coordinator?, Void)?
    var invokedRemoveDependencyParametersList = [(coordinator: Coordinator?, Void)]()
    override func removeDependency(_ coordinator: Coordinator?) {
        invokedRemoveDependency = true
        invokedRemoveDependencyCount += 1
        invokedRemoveDependencyParameters = (coordinator, ())
        invokedRemoveDependencyParametersList.append((coordinator, ()))
    }
}

