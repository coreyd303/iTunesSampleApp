//
//  WindowProviding.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import UIKit

protocol WindowProviding: class {
    func setRootPresentable(_ presentable: Presentable)
}

extension UIWindow: WindowProviding {

    /// set passed Presentable as rootViewController
    /// - Parameter presentable: Presentable object to be set as rootVC
    func setRootPresentable(_ presentable: Presentable) {
        rootViewController = presentable.toPresent()
        makeKeyAndVisible()
    }
}
