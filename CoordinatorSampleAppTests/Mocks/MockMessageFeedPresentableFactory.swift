//
//  MockMessageFeedPresentableFactory.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import CoordinatorSampleApp

class MockMessageFeedPresentableFactory: MessageFeedPresentableFactory {
    var invokedMakeMessageFeedViewModel = false
    var invokedMakeMessageFeedViewModelCount = 0
    var stubbedMakeMessageFeedViewModelResult: MessageFeedViewModel!
    func makeMessageFeedViewModel() -> MessageFeedViewModel {
        invokedMakeMessageFeedViewModel = true
        invokedMakeMessageFeedViewModelCount += 1
        return stubbedMakeMessageFeedViewModelResult
    }
    var invokedMakeMessageFeedPresentable = false
    var invokedMakeMessageFeedPresentableCount = 0
    var stubbedMakeMessageFeedPresentableResult: MessageFeedPresentable!
    func makeMessageFeedPresentable() -> MessageFeedPresentable {
        invokedMakeMessageFeedPresentable = true
        invokedMakeMessageFeedPresentableCount += 1
        return stubbedMakeMessageFeedPresentableResult
    }
    var invokedMakeSignInAlertPresentable = false
    var invokedMakeSignInAlertPresentableCount = 0
    var stubbedMakeSignInAlertPresentableResult: UIAlertController!
    func makeSignInAlertPresentable() -> UIAlertController {
        invokedMakeSignInAlertPresentable = true
        invokedMakeSignInAlertPresentableCount += 1
        return stubbedMakeSignInAlertPresentableResult
    }
    var invokedMakeAddMessageAlertPresentable = false
    var invokedMakeAddMessageAlertPresentableCount = 0
    var stubbedMakeAddMessageAlertPresentableResult: UIAlertController!
    func makeAddMessageAlertPresentable() -> UIAlertController {
        invokedMakeAddMessageAlertPresentable = true
        invokedMakeAddMessageAlertPresentableCount += 1
        return stubbedMakeAddMessageAlertPresentableResult
    }
}
