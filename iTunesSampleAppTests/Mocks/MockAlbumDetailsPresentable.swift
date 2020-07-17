//
//  MockAlbumDetailsPresentable.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import iTunesSampleApp

class MockAblumDetailsPresentable: AlbumDetailsPresentable {
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
    var invokedDidRequestAlbumSetter = false
    var invokedDidRequestAlbumSetterCount = 0
    var invokedDidRequestAlbum: ((String) -> ())?
    var invokedDidRequestAlbumList = [((String) -> ())?]()
    var invokedDidRequestAlbumGetter = false
    var invokedDidRequestAlbumGetterCount = 0
    var stubbedDidRequestAlbum: ((String) -> ())!
    var didRequestAlbum: ((String) -> ())? {
        set {
            invokedDidRequestAlbumSetter = true
            invokedDidRequestAlbumSetterCount += 1
            invokedDidRequestAlbum = newValue
            invokedDidRequestAlbumList.append(newValue)
        }
        get {
            invokedDidRequestAlbumGetter = true
            invokedDidRequestAlbumGetterCount += 1
            return stubbedDidRequestAlbum
        }
    }
    var invokedViewModelSetter = false
    var invokedViewModelSetterCount = 0
    var invokedViewModel: AlbumDetailsViewModel?
    var invokedViewModelList = [AlbumDetailsViewModel?]()
    var invokedViewModelGetter = false
    var invokedViewModelGetterCount = 0
    var stubbedViewModel: AlbumDetailsViewModel!
    var viewModel: AlbumDetailsViewModel? {
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
