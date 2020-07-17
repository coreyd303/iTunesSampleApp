//
//  BasePresentableFactory.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol BasePresentableFactory {
    func makeRouter() -> Router
}

class BasePresentableFactoryImplementation: BasePresentableFactory {

    // MARK: - Public

    /// Create a base instance of Router
    /// - Returns: a configured Router instance
    func makeRouter() -> Router {
        let navigationController = UINavigationController()
        return RouterImplementation(rootController: navigationController)
    }
}
