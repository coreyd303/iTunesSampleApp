//
//  MockMessageFeedChildCoordinatorFactory.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockMessageFeedChildCoordinatorFactory: MessageFeedChildCoordinatorFactory {
    var invokedMakeFilterPickerCoordinator = false
    var invokedMakeFilterPickerCoordinatorCount = 0
    var stubbedMakeFilterPickerCoordinatorResult: FilterPickerCoordinator!
    func makeFilterPickerCoordinator() -> FilterPickerCoordinator {
        invokedMakeFilterPickerCoordinator = true
        invokedMakeFilterPickerCoordinatorCount += 1
        return stubbedMakeFilterPickerCoordinatorResult
    }
}
