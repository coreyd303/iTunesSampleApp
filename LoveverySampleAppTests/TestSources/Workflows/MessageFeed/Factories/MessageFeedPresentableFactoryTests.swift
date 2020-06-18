//
//  MessageFeedPresentableFactoryTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import LoveverySampleApp

class MessageFeedPresentableFactoryTests: QuickSpec {
    override func spec() {
        var sut: MessageFeedPresentableFactoryImplementation!
        var mockService: MockUserService!

        beforeEach {
            mockService = MockUserService()
            sut = MessageFeedPresentableFactoryImplementation(userService: mockService)
        }

        describe("a MessageFeedPresentableFactoryImplementation") {
            it("should be a type of MessageFeedPresentableFactory") {
                expect(sut).to(beAKindOf(MessageFeedPresentableFactory.self))
            }

            it("should be an instance of MessageFeedPresentableFactoryImplementation") {
                expect(sut).to(beAnInstanceOf(MessageFeedPresentableFactoryImplementation.self))
            }

            describe("makeMessageFeedViewModel") {
                var viewModel: MessageFeedViewModel!

                beforeEach {
                    viewModel = sut.makeMessageFeedViewModel()
                }

                it("should be a type of MessageFeedViewModel") {
                    expect(viewModel).to(beAKindOf(MessageFeedViewModel.self))
                }

                it("should be an instance of MessageFeedViewModelImplementation") {
                    expect(viewModel).to(beAnInstanceOf(MessageFeedViewModelImplementation.self))
                }
            }

            describe("makeMessageFeedPresentable") {
                var presentable: MessageFeedPresentable!

                beforeEach {
                    presentable = sut.makeMessageFeedPresentable()
                }

                it("should be at type of MessageFeedPresentable") {
                    expect(presentable).to(beAKindOf(MessageFeedPresentable.self))
                }

                it("should be an instance of MessageFeedViewController") {
                    expect(presentable).to(beAnInstanceOf(MessageFeedViewController.self))
                }
            }

            describe("makeSignInAlertPresentable") {
                var alert: UIAlertController!

                beforeEach {
                    alert = sut.makeSignInAlertPresentable()
                }

                it("should be an instance of UIAlertController") {
                    expect(alert).to(beAnInstanceOf(UIAlertController.self))
                }

                it("should have a textfield with a matching placeholder") {
                    expect(alert.textFields?[0].placeholder).to(equal("What is your name?"))
                }
            }

            describe("makeAddMessageAlertPresentable") {
                var alert: UIAlertController!

                beforeEach {
                    alert = sut.makeAddMessageAlertPresentable()
                }

                it("should be an instance of UIAlertController") {
                    expect(alert).to(beAnInstanceOf(UIAlertController.self))
                }

                it("should invoke currentUser on the service") {
                    expect(mockService.invokedCurrentUserCount).to(equal(1))
                }

                it("should have a subject textField") {
                    expect(alert.textFields?[0].placeholder).to(equal("Subject"))
                }

                it("should have a message textField") {
                    expect(alert.textFields?[1].placeholder).to(equal("Message"))
                }
            }
        }
    }
}
