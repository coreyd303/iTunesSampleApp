//
//  MockMessageFeedPresentable.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import CoordinatorSampleApp

class MockMessageFeedPresentable: MessageFeedPresentable, MessageDelegate {
    var invokedDidFinishSetter = false
    var invokedDidFinishSetterCount = 0
    var invokedDidFinish: (() -> ())?
    var invokedDidFinishList = [(() -> ())?]()
    var invokedDidFinishGetter = false
    var invokedDidFinishGetterCount = 0
    var stubbedDidFinish: (() -> ())!
    var didFinish: (() -> ())? {
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
    var invokedDidTapAddMessageSetter = false
    var invokedDidTapAddMessageSetterCount = 0
    var invokedDidTapAddMessage: (() -> ())?
    var invokedDidTapAddMessageList = [(() -> ())?]()
    var invokedDidTapAddMessageGetter = false
    var invokedDidTapAddMessageGetterCount = 0
    var stubbedDidTapAddMessage: (() -> ())!
    var didTapAddMessage: (() -> ())? {
        set {
            invokedDidTapAddMessageSetter = true
            invokedDidTapAddMessageSetterCount += 1
            invokedDidTapAddMessage = newValue
            invokedDidTapAddMessageList.append(newValue)
        }
        get {
            invokedDidTapAddMessageGetter = true
            invokedDidTapAddMessageGetterCount += 1
            return stubbedDidTapAddMessage
        }
    }
    var invokedDidTapSignInSetter = false
    var invokedDidTapSignInSetterCount = 0
    var invokedDidTapSignIn: (() -> ())?
    var invokedDidTapSignInList = [(() -> ())?]()
    var invokedDidTapSignInGetter = false
    var invokedDidTapSignInGetterCount = 0
    var stubbedDidTapSignIn: (() -> ())!
    var didTapSignIn: (() -> ())? {
        set {
            invokedDidTapSignInSetter = true
            invokedDidTapSignInSetterCount += 1
            invokedDidTapSignIn = newValue
            invokedDidTapSignInList.append(newValue)
        }
        get {
            invokedDidTapSignInGetter = true
            invokedDidTapSignInGetterCount += 1
            return stubbedDidTapSignIn
        }
    }
    var invokedDidTapFilterMessagesSetter = false
    var invokedDidTapFilterMessagesSetterCount = 0
    var invokedDidTapFilterMessages: (([String?]) -> ())?
    var invokedDidTapFilterMessagesList = [(([String?]) -> ())?]()
    var invokedDidTapFilterMessagesGetter = false
    var invokedDidTapFilterMessagesGetterCount = 0
    var stubbedDidTapFilterMessages: (([String?]) -> ())!
    var didTapFilterMessages: (([String?]) -> ())? {
        set {
            invokedDidTapFilterMessagesSetter = true
            invokedDidTapFilterMessagesSetterCount += 1
            invokedDidTapFilterMessages = newValue
            invokedDidTapFilterMessagesList.append(newValue)
        }
        get {
            invokedDidTapFilterMessagesGetter = true
            invokedDidTapFilterMessagesGetterCount += 1
            return stubbedDidTapFilterMessages
        }
    }
    var invokedViewModelSetter = false
    var invokedViewModelSetterCount = 0
    var invokedViewModel: MessageFeedViewModel?
    var invokedViewModelList = [MessageFeedViewModel?]()
    var invokedViewModelGetter = false
    var invokedViewModelGetterCount = 0
    var stubbedViewModel: MessageFeedViewModel!
    var viewModel: MessageFeedViewModel? {
        set {
            invokedViewModelSetter = true
            invokedViewModelSetterCount += 1
            invokedViewModel = newValue
            invokedViewModelList.append(newValue)
        }
        get {
            invokedViewModelGetter = true
            invokedViewModelGetterCount += 1
            return stubbedViewModel
        }
    }
    var invokedSetNavigation = false
    var invokedSetNavigationCount = 0
    func setNavigation() {
        invokedSetNavigation = true
        invokedSetNavigationCount += 1
    }
    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (error: Error, Void)?
    var invokedPresentParametersList = [(error: Error, Void)]()
    func present(error: Error) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (error, ())
        invokedPresentParametersList.append((error, ()))
    }
    var invokedDidUpdateMessages = false
    var invokedDidUpdateMessagesCount = 0
    var invokedDidUpdateMessagesParameters: (error: Error?, filter: String?)?
    var invokedDidUpdateMessagesParametersList = [(error: Error?, filter: String?)]()
    func didUpdateMessages(_ error: Error?, filter: String?) {
        invokedDidUpdateMessages = true
        invokedDidUpdateMessagesCount += 1
        invokedDidUpdateMessagesParameters = (error, filter)
        invokedDidUpdateMessagesParametersList.append((error, filter))
    }
    var invokedToPresent = false
    var invokedToPresentCount = 0
    var stubbedToPresentResult: UIViewController!
    func toPresent() -> UIViewController {
        invokedToPresent = true
        invokedToPresentCount += 1
        return stubbedToPresentResult
    }
    var invokedPresentAnimated = false
    var invokedPresentAnimatedCount = 0
    var invokedPresentAnimatedParameters: (presentable: Presentable, animated: Bool)?
    var invokedPresentAnimatedParametersList = [(presentable: Presentable, animated: Bool)]()
    var shouldInvokePresentAnimatedCompletion = false
    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        invokedPresentAnimated = true
        invokedPresentAnimatedCount += 1
        invokedPresentAnimatedParameters = (presentable, animated)
        invokedPresentAnimatedParametersList.append((presentable, animated))
        if shouldInvokePresentAnimatedCompletion {
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
