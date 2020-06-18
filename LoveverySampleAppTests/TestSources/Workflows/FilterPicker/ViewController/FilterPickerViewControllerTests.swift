//
//  FilterPickerViewControllerTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import LoveverySampleApp

class FilterPickerViewControllerTests: QuickSpec {
    override func spec() {
        var sut: FilterPickerViewController!
        var invokedDidFinishCount: Int!
        var invokedDidSelectFilterCount: Int!
        var invokedDidSelectFilterParams: (name: String?, Void)?
        let stubNames = ["bob", "john"]

        beforeEach {
            sut = FilterPickerViewController()
            UITestUtilities().setup(withViewController: sut)

            invokedDidFinishCount = 0
            sut.didFinish = {
                invokedDidFinishCount += 1
            }

            invokedDidSelectFilterCount = 0
            invokedDidSelectFilterParams = nil
            sut.didSelectFilter = { name in
                invokedDidSelectFilterCount += 1
                invokedDidSelectFilterParams = (name, ())
            }

            sut.names = stubNames
        }

        describe("a FilterPickerViewController") {
            it("should be a type of FilterPickerPresentable") {
                expect(sut).to(beAKindOf(FilterPickerPresentable.self))
            }

            it("should be a type of FilterPickerViewController") {
                expect(sut).to(beAnInstanceOf(FilterPickerViewController.self))
            }

            describe("viewDidLayoutSubviews") {
                beforeEach {
                    sut.viewDidLayoutSubviews()
                }

                describe("when applyDesign is invoked") {
                    it("should have a title label") {
                        expect(sut.titleLabel).to(beAnInstanceOf(UILabel.self))
                    }

                    it("should have a picker") {
                        expect(sut.picker).to(beAnInstanceOf(UIPickerView.self))
                    }

                    it("should have a close button") {
                        expect(sut.closeButton).to(beAnInstanceOf(UIButton.self))
                    }

                    it("should have a select button") {
                        expect(sut.selectButton).to(beAnInstanceOf(UIButton.self))
                    }
                }

                describe("when closeButton is tapped") {
                    beforeEach {
                        sut.closeButton.sendActions(for: .touchUpInside)
                    }

                    it("should invoke didFinish on sut") {
                        expect(invokedDidFinishCount).to(equal(1))
                    }
                }

                describe("when selectButton is tapped") {
                    beforeEach {
                        sut.picker.selectRow(1, inComponent: 0, animated: false)
                        sut.selectButton.sendActions(for: .touchUpInside)
                    }

                    it("should invoke didSelectFilter") {
                        expect(invokedDidSelectFilterCount).to(equal(1))
                    }

                    it("should invoke didSelectFilter with matching name") {
                        expect(invokedDidSelectFilterParams?.name).to(equal(stubNames[1]))
                    }
                }
            }

            context("sut as UIPickerViewDelegate") {
                describe("titleForRow") {
                    var title: String!

                    beforeEach {
                        title = sut.pickerView(UIPickerView(), titleForRow: 0, forComponent: 0)
                    }

                    it("should return a matching name") {
                        expect(title).to(equal(stubNames[0].capitalized))
                    }
                }
            }

            context("sut as UIPickerViewDataSource") {
                describe("numberOfComponents") {
                    it("should return a matching number of components") {
                        let numberOfComponents = sut.numberOfComponents(in: UIPickerView())

                        expect(numberOfComponents).to(equal(1))
                    }
                }

                describe("numberOfRowsInComponent") {
                    it("should return a matching number of rows") {
                        let rows = sut.pickerView(UIPickerView(), numberOfRowsInComponent: 0)

                        expect(rows).to(equal(stubNames.count))
                    }
                }
            }
        }
    }
}
