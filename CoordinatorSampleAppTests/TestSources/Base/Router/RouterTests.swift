//
//  RouterTests.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import CoordinatorSampleApp

class RouterTests: QuickSpec {
    override func spec() {
        var sut: Router!
        var mockNavigationController: MockNavigationController!
        var mockPresentable: MockPresentable!
        var stubbedViewController: UIViewController!

        beforeEach {
            mockNavigationController = MockNavigationController()
            mockPresentable = MockPresentable()
            stubbedViewController = UIViewController()
            mockPresentable.stubbedToPresentResult = stubbedViewController
            sut = RouterImplementation(rootController: mockNavigationController)
        }

        describe("a RouterImplementation") {
            it("should be a type of Router") {
                expect(sut).to(beAKindOf(Router.self))
            }

            it("should be an instance of RouterImplemenation") {
                expect(sut).to(beAnInstanceOf(RouterImplementation.self))
            }

            describe("push") {
                it("should invoke push") {
                    sut.push(mockPresentable)

                    expect(mockNavigationController.invokedPushViewControllerCount).to(equal(1))
                }

                it("should push with a matching presentable") {
                    sut.push(mockPresentable)
                    expect(mockNavigationController.invokedPushViewControllerParameters?.viewController).to(be(stubbedViewController))
                }
            }

            describe("pop") {
                it("should invoke pop") {
                    sut.pop()

                    expect(mockNavigationController.invokedPopViewControllerCount).to(equal(1))
                }
            }

            describe("setRootPresentable") {
                it("should update viewControllers") {
                    sut.setRootPresentable(mockPresentable)

                    expect(mockNavigationController.viewControllers.count).to(equal(1))
                }
            }

            describe("toPresent") {
                it("should return a matching viewController") {
                    expect(sut.toPresent()).to(be(mockNavigationController))
                }
            }

            describe("present") {
                it("should invoke present") {
                    sut.present(mockPresentable, animated: true, completion: nil)

                    expect(mockNavigationController.invokedPresentCount).to(equal(1))
                }

                it("should invoke present with a matching viewController") {
                    sut.present(mockPresentable, animated: true, completion: nil)

                    expect(mockNavigationController.invokedPresentParameters?.viewControllerToPresent).to(equal(mockPresentable.toPresent()))
                }

                it("should invoke with matching animated") {
                    sut.present(mockPresentable, animated: false, completion: nil)

                    expect(mockNavigationController.invokedPresentParameters?.animated).to(beFalse())
                }

                it("should call its completion") {
                    var invokedCompletionCount = 0

                    sut.present(mockPresentable, animated: true, completion: {
                        invokedCompletionCount += 1
                    })

                    expect(invokedCompletionCount).to(equal(1))
                }
            }

            describe("dismissPresentable") {
                it("should invoke dismiss") {
                    sut.dismissPresentable(animated: true, completion: nil)

                    expect(mockNavigationController.invokedDismissCount).to(equal(1))
                }

                it("should invoked with matching animated") {
                    sut.dismissPresentable(animated: false, completion: nil)

                    expect(mockNavigationController.invokedDismissParameters?.animated).to(beFalse())
                }

                it("should call its completion") {
                    var invokedCompletionCount = 0

                    sut.dismissPresentable(animated: true, completion: {
                        invokedCompletionCount += 1
                    })

                    expect(invokedCompletionCount).to(equal(1))
                }
            }
        }
    }
}
