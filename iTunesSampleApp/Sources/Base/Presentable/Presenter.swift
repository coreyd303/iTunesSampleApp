//
//  Presenter.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import UIKit

@objc protocol Presenter: class {
    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?)
    func dismissPresentable(animated: Bool, completion: (() -> Void)?)
}

extension UIViewController: Presenter {

    // MARK: - Public

    /// wrapper around present
    /// - Parameters:
    ///   - presentable: the Presentable object to provide to the stack
    ///   - animated: bool to indicate animations requirement
    ///   - completion: optional callback when done
    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        present(presentable.toPresent(), animated: animated, completion: completion)
    }

    /// wrapper around dismiss
    /// - Parameters:
    ///   - animated: bool to indicate animation requirement
    ///   - completion: optional callback when done
    func dismissPresentable(animated: Bool, completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }
}

