//
//  FilterPickerPresentableFactoryTests.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import CoordinatorSampleApp

class FilterPickerPresentableFactoryTests: QuickSpec {
    override func spec() {
        var sut: FilterPickerPresentableFactoryImplementation!

        beforeEach {
            sut = FilterPickerPresentableFactoryImplementation()
        }

        describe("a FilterPickerPresentableFactoryImplementation") {
            it("should be a type of FilterPickerPresentableFactory") {
                expect(sut).to(beAKindOf(FilterPickerPresentableFactory.self))
            }

            it("should be an instance of FilterPickerPresentableFactoryImplementation") {
                expect(sut).to(beAnInstanceOf(FilterPickerPresentableFactoryImplementation.self))
            }

            describe("makeFilterPickerPresentable") {
                var presentable: FilterPickerPresentable!

                beforeEach {
                    presentable = sut.makeFilterPickerPresentable()
                }

                it("should return a type of FilterPickerPresentable") {
                    expect(presentable).to(beAKindOf(FilterPickerPresentable.self))
                }

                it("should return a type of FilterPickerViewController") {
                    expect(presentable).to(beAnInstanceOf(FilterPickerViewController.self))
                }
            }
        }
    }
}
