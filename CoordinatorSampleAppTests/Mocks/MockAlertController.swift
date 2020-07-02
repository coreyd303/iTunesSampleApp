//
//  MockAlertController.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import CoordinatorSampleApp

class MockAlertController: UIAlertController {

    func reset() {
        invokedActions = []
    }

    var invokedTextFields: [UITextField]?
    var stubbedTextFields: [UITextField]?
    override var textFields: [UITextField]? {
        set {
            invokedTextFields = newValue
        }
        get {
            return stubbedTextFields
        }
    }

    var invokedAddActionCount = 0
    var invokedAddActionParams: (actions: [UIAlertAction], Void)?
    var invokedActions: [UIAlertAction] = []
    override func addAction(_ action: UIAlertAction) {
        actions.append(action)
        invokedAddActionCount += 1
        invokedAddActionParams = (actions, ())
    }

    override var actions: [UIAlertAction] {
        set {
            invokedActions.append(contentsOf: newValue)
        }
        get {
            return invokedActions
        }
    }
}
