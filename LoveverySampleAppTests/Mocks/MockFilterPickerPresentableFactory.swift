//
//  MockFilterPickerPresentableFactory.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockFilterPickerPresentableFactory: FilterPickerPresentableFactory {
    var invokedMakeFilterPickerPresentable = false
    var invokedMakeFilterPickerPresentableCount = 0
    var stubbedMakeFilterPickerPresentableResult: FilterPickerPresentable!
    func makeFilterPickerPresentable() -> FilterPickerPresentable {
        invokedMakeFilterPickerPresentable = true
        invokedMakeFilterPickerPresentableCount += 1
        return stubbedMakeFilterPickerPresentableResult
    }
}
