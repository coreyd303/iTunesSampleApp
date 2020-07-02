//
//  FilterPickerPresentableFactory.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol FilterPickerPresentableFactory: class {
    func makeFilterPickerPresentable() -> FilterPickerPresentable
}

class FilterPickerPresentableFactoryImplementation: FilterPickerPresentableFactory {

    // MARK: - Public

    /// create and instance of FilterPickerPresentable
    /// - Returns: FilterPickerViewController as FilterPickerPresentable
    func makeFilterPickerPresentable() -> FilterPickerPresentable {
        return FilterPickerViewController()
    }
}
