//
//  Presentable.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import UIKit

@objc protocol Presentable: Presenter {
    @objc func toPresent() -> UIViewController
}

extension UIViewController: Presentable {
    @objc func toPresent() -> UIViewController {
        return self
    }
}
