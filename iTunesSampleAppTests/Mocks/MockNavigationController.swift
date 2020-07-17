//
//  MockNavigationController.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import iTunesSampleApp

class MockNavigationController: UINavigationController {
    func reset() {
        invokedPushViewControllerCount = 0
        invokedPopViewControllerCount = 0
        invokedPresentCount = 0
        invokedDismissCount = 0
        stubbedPopViewControllerResult = nil
    }

    var invokedPushViewControllerCount = 0
    var invokedPushViewControllerParameters: (viewController: UIViewController, animated: Bool)?
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        invokedPushViewControllerCount += 1
        invokedPushViewControllerParameters = (viewController, animated)
    }

    var invokedPopViewControllerCount = 0
    var invokedPopViewControllerParameters: (animated: Bool, ())?
    var stubbedPopViewControllerResult: UIViewController?
    override func popViewController(animated: Bool) -> UIViewController? {
        invokedPopViewControllerCount += 1
        invokedPopViewControllerParameters = (animated, ())
        return stubbedPopViewControllerResult
    }

    var invokedPresentCount = 0
    var invokedPresentParameters: (viewControllerToPresent: UIViewController, animated: Bool)?
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        invokedPresentCount += 1
        invokedPresentParameters = (viewControllerToPresent, flag)
        completion?()
    }

    var invokedDismissCount = 0
    var invokedDismissParameters: (animated: Bool, ())?
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        invokedDismissCount += 1
        invokedDismissParameters = (flag, ())
        completion?()
    }
}
