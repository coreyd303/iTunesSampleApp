//
//  MockFilterPickerCoordinator.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import CoordinatorSampleApp

class MockFilterPickerCoordinator: FilterPickerCoordinator {
    var invokedDidFinishSetter = false
    var invokedDidFinishSetterCount = 0
    var invokedDidFinish: ((String?) -> ())?
    var invokedDidFinishList = [((String?) -> ())?]()
    var invokedDidFinishGetter = false
    var invokedDidFinishGetterCount = 0
    var stubbedDidFinish: ((String?) -> ())!
    var didFinish: ((String?) -> ())? {
        set {
            invokedDidFinishSetter = true
            invokedDidFinishSetterCount += 1
            invokedDidFinish = newValue
            invokedDidFinishList.append(newValue)
        }
        get {
            invokedDidFinishGetter = true
            invokedDidFinishGetterCount += 1
            return stubbedDidFinish
        }
    }
    var invokedStartWith = false
    var invokedStartWithCount = 0
    var invokedStartWithParameters: (names: [String?], Void)?
    var invokedStartWithParametersList = [(names: [String?], Void)]()
    func start(with names: [String?]) {
        invokedStartWith = true
        invokedStartWithCount += 1
        invokedStartWithParameters = (names, ())
        invokedStartWithParametersList.append((names, ()))
    }
    var invokedStart = false
    var invokedStartCount = 0
    func start() {
        invokedStart = true
        invokedStartCount += 1
    }
}
