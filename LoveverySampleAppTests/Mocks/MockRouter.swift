//
//  MockRouter.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import LoveverySampleApp

class MockRouter: Router {
    var invokedRootControllerGetter = false
    var invokedRootControllerGetterCount = 0
    var stubbedRootController: UINavigationController!
    var rootController: UINavigationController {
        invokedRootControllerGetter = true
        invokedRootControllerGetterCount += 1
        return stubbedRootController
    }
    var invokedPush = false
    var invokedPushCount = 0
    var invokedPushParameters: (presentable: Presentable, Void)?
    var invokedPushParametersList = [(presentable: Presentable, Void)]()
    func push(_ presentable: Presentable) {
        invokedPush = true
        invokedPushCount += 1
        invokedPushParameters = (presentable, ())
        invokedPushParametersList.append((presentable, ()))
    }
    var invokedPop = false
    var invokedPopCount = 0
    func pop() {
        invokedPop = true
        invokedPopCount += 1
    }
    var invokedSetRootPresentable = false
    var invokedSetRootPresentableCount = 0
    var invokedSetRootPresentableParameters: (presentable: Presentable, Void)?
    var invokedSetRootPresentableParametersList = [(presentable: Presentable, Void)]()
    func setRootPresentable(_ presentable: Presentable) {
        invokedSetRootPresentable = true
        invokedSetRootPresentableCount += 1
        invokedSetRootPresentableParameters = (presentable, ())
        invokedSetRootPresentableParametersList.append((presentable, ()))
    }
    var invokedToPresent = false
    var invokedToPresentCount = 0
    var stubbedToPresentResult: UIViewController!
    func toPresent() -> UIViewController {
        invokedToPresent = true
        invokedToPresentCount += 1
        return stubbedToPresentResult
    }
    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (presentable: Presentable, animated: Bool)?
    var invokedPresentParametersList = [(presentable: Presentable, animated: Bool)]()
    var shouldInvokePresentCompletion = false
    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (presentable, animated)
        invokedPresentParametersList.append((presentable, animated))
        if shouldInvokePresentCompletion {
            completion?()
        }
    }
    var invokedDismissPresentable = false
    var invokedDismissPresentableCount = 0
    var invokedDismissPresentableParameters: (animated: Bool, Void)?
    var invokedDismissPresentableParametersList = [(animated: Bool, Void)]()
    var shouldInvokeDismissPresentableCompletion = false
    func dismissPresentable(animated: Bool, completion: (() -> Void)?) {
        invokedDismissPresentable = true
        invokedDismissPresentableCount += 1
        invokedDismissPresentableParameters = (animated, ())
        invokedDismissPresentableParametersList.append((animated, ()))
        if shouldInvokeDismissPresentableCompletion {
            completion?()
        }
    }
}
