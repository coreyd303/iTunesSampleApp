//
//  Router.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol Router: Presentable {
    var rootController: UINavigationController { get }
    func push(_ presentable: Presentable)
    func pop()
    func setRootPresentable(_ presentable: Presentable)
}

class RouterImplementation: Router {

    // MARK: - Properties

    private(set) var rootController: UINavigationController

    // MARK: - Initialization

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }

    // MARK: - Public

    /// wrapper around pushViewController
    /// - Parameter presentable: Presentable to be pushed
    func push(_ presentable: Presentable) {
        rootController.pushViewController(presentable.toPresent(), animated: true)
    }

    /// wrapper around popViewController
    func pop() {
        rootController.popViewController(animated: true)
    }

    /// wrapper around rootController.viewControllers assignment
    /// - Parameter presentable: Presentable to be set on rootController
    func setRootPresentable(_ presentable: Presentable) {
        rootController.viewControllers = [presentable.toPresent()]
    }

    /// a way to conveiniently access the UIViewController instance of a Presentable
    /// - Returns: Presentable as! UIViewController
    func toPresent() -> UIViewController {
        return rootController
    }

    /// wrapper around viewController.present
    /// - Parameters:
    ///   - presentable: The Presentable to present on the rootController
    ///   - animated: bool if to animate presentation
    ///   - completion: optional call back when done
    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        rootController.present(presentable.toPresent(), animated: animated, completion: completion)
    }

    /// wrapper around viewController.dismiss
    /// - Parameters:
    ///   - animated: bool if to animation dismissal
    ///   - completion: optional callback when done
    func dismissPresentable(animated: Bool, completion: (() -> Void)?) {
        rootController.dismiss(animated: animated, completion: completion)
    }
}
