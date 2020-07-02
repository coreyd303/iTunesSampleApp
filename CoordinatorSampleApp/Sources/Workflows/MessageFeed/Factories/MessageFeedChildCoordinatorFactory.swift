//
//  MessageFeedChildCoordinatorFactory.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol MessageFeedChildCoordinatorFactory: class {
    func makeFilterPickerCoordinator() -> FilterPickerCoordinator
}

class MessageFeedChildCoordinatorFactoryImplementation: MessageFeedChildCoordinatorFactory {

    // MARK: - Properties

    private let router: Router

    // MARK: - Initialization

    init(router: Router) {
        self.router = router
    }

    /// create an instance of FilterPickerCoordinator
    /// - Returns: an instance of FilterPickerCoordinatorImplementation
    func makeFilterPickerCoordinator() -> FilterPickerCoordinator {
        let presentableFactory = FilterPickerPresentableFactoryImplementation()
        return FilterPickerCoordinatorImplementation(router: router, presentableFactory: presentableFactory)
    }
}
