//
//  MockWindowProviding.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import CoordinatorSampleApp

class MockWindowProviding: WindowProviding {
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
}
