//
//  MockUserDefaults.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockUserDefaults: UserDefaults {
    var invokedSetValueCount = 0
    var invokedSetValueParameters: (value: Any?, defaultName: String)?
    override func set(_ value: Any?, forKey defaultName: String) {
        invokedSetValueCount += 1
        invokedSetValueParameters = (value, defaultName)
    }

    var invokedObjectForKeyCount = 0
    var invokedObjectForKeyParameters: (defaultName: String, Void)?
    var stubbedObjectForKey: Data?
    override func object(forKey defaultName: String) -> Any? {
        invokedObjectForKeyCount += 1
        invokedObjectForKeyParameters = (defaultName, ())
        return stubbedObjectForKey
    }

    var invokedRemoveObjectForKeyCount = 0
    var invokedRemoveObjectForKeyParameters: (defaultName: String, Void)?
    override func removeObject(forKey defaultName: String) {
        invokedRemoveObjectForKeyCount += 1
        invokedRemoveObjectForKeyParameters = (defaultName, ())
    }
}
