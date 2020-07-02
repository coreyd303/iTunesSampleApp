//
//  MockFilterPickerPresentable.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import CoordinatorSampleApp

class MockFilterPickerPresentable: FilterPickerPresentable {
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
    var invokedDidSelectFilterSetter = false
    var invokedDidSelectFilterSetterCount = 0
    var invokedDidSelectFilter: ((String?) -> ())?
    var invokedDidSelectFilterList = [((String?) -> ())?]()
    var invokedDidSelectFilterGetter = false
    var invokedDidSelectFilterGetterCount = 0
    var stubbedDidSelectFilter: ((String?) -> ())!
    var didSelectFilter: ((String?) -> ())? {
        set {
            invokedDidSelectFilterSetter = true
            invokedDidSelectFilterSetterCount += 1
            invokedDidSelectFilter = newValue
            invokedDidSelectFilterList.append(newValue)
        }
        get {
            invokedDidSelectFilterGetter = true
            invokedDidSelectFilterGetterCount += 1
            return stubbedDidSelectFilter
        }
    }
    var invokedNamesSetter = false
    var invokedNamesSetterCount = 0
    var invokedNames: [String?]?
    var invokedNamesList = [[String?]]()
    var invokedNamesGetter = false
    var invokedNamesGetterCount = 0
    var stubbedNames: [String?]! = []
    var names: [String?] {
        set {
            invokedNamesSetter = true
            invokedNamesSetterCount += 1
            invokedNames = newValue
            invokedNamesList.append(newValue)
        }
        get {
            invokedNamesGetter = true
            invokedNamesGetterCount += 1
            return stubbedNames
        }
    }
    var invokedToPresent = false
    var invokedToPresentCount = 0
    var stubbedToPresentResult: UIViewController!
    func toPresent() -> UIViewController {
        invokedToPresent = true
        invokedToPresentCount += 1
        return stubbedToPresentResult
    }
    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (presentable: Presentable, animated: Bool)?
    var invokedPresentParametersList = [(presentable: Presentable, animated: Bool)]()
    var shouldInvokePresentCompletion = false
    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (presentable, animated)
        invokedPresentParametersList.append((presentable, animated))
        if shouldInvokePresentCompletion {
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
