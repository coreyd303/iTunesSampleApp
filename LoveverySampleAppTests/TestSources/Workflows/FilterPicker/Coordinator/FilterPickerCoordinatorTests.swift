//
//  FilterPickerCoordinatorTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import LoveverySampleApp

class FilterPickerCoordinatorTests: QuickSpec {

    override func spec() {
        var sut: FilterPickerCoordinatorImplementation!
        var mockRouter: MockRouter!
        var mockFactory: MockFilterPickerPresentableFactory!
        var mockPresentable: MockFilterPickerPresentable!
        var invokedDidFinishCount: Int!
        var invokedDidFinishParams: (value: String?, Void)?
        let stubNames = ["bob", "john"]

        beforeEach {
            mockRouter = MockRouter()
            mockPresentable = MockFilterPickerPresentable()
            mockFactory = MockFilterPickerPresentableFactory()
            mockFactory.stubbedMakeFilterPickerPresentableResult = mockPresentable

            sut = FilterPickerCoordinatorImplementation(router: mockRouter, presentableFactory: mockFactory)

            invokedDidFinishCount = 0
            invokedDidFinishParams = nil
            sut.didFinish = { value in
                invokedDidFinishCount += 1
                invokedDidFinishParams = (value, ())
            }
        }

        describe("a FilterPickerCoordinatorImplementation") {
            it("should be a type of FilterPickerCoordinator") {
                expect(sut).to(beAKindOf(FilterPickerCoordinator.self))
            }

            it("should be an instance of FilterPickerCoordinatorImplementation") {
                expect(sut).to(beAnInstanceOf(FilterPickerCoordinatorImplementation.self))
            }

            describe("start with names") {
                beforeEach {
                    sut.start(with: stubNames)
                }

                it("should invoke makeFilterPickerPresentable on the factory") {
                    expect(mockFactory.invokedMakeFilterPickerPresentableCount).to(equal(1))
                }

                it("should set names on the presentable") {
                    expect(mockPresentable.invokedNamesSetterCount).to(equal(1))
                }

                it("should set matching names on the presentable") {
                    expect(mockPresentable.invokedNames).to(equal(stubNames))
                }

                it("should set didFinish on the presentable") {
                    expect(mockPresentable.invokedDidFinishSetterCount).to(equal(1))
                }

                describe("when didFinish is invoked on the presentable") {
                    beforeEach {
                        mockPresentable.invokedDidFinish?()
                    }

                    it("should invoke didFinish on sut") {
                        expect(invokedDidFinishCount).to(equal(1))
                    }

                    it("should invoked didFinish on sut with matching value") {
                        expect(invokedDidFinishParams?.value).to(beNil())
                    }
                }

                it("should set didSelectFilter on the presentable") {
                    expect(mockPresentable.invokedDidSelectFilterSetterCount).to(equal(1))
                }

                describe("when didSelectFilter is invoked on the presentable") {
                    beforeEach {
                        mockPresentable.invokedDidSelectFilter?("Woot!")
                    }

                    it("should invoke didFinish on sut") {
                        expect(invokedDidFinishCount).to(equal(1))
                    }

                    it("should invoke didFinish on sut with matching value") {
                        expect(invokedDidFinishParams?.value).to(equal("Woot!"))
                    }
                }

                describe("when start is invoked") {
                    it("should invoke present on the router") {
                        expect(mockRouter.invokedPresentCount).to(equal(1))
                    }

                    it("should invoked present on the router with matching presentable") {
                        expect(mockRouter.invokedPresentParameters?.presentable).to(be(mockPresentable))
                    }
                }
            }
        }
    }
}
