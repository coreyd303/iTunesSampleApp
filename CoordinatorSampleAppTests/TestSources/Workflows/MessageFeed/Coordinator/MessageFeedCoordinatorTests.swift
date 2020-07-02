//
//  MessageFeedCoordinatorTests.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import CoordinatorSampleApp

class MessageFeedCoordinatorTests: QuickSpec {
    override func spec() {
        var sut: MessageFeedCoordinatorImplementation!
        var mockRouter: MockRouter!
        var mockPresentable: MockMessageFeedPresentable!
        var mockAlert: MockAlertController!
        var mockViewModel: MockMessageFeedViewModel!
        var mockPresentableFactory: MockMessageFeedPresentableFactory!
        var mockChildCoordinator: MockFilterPickerCoordinator!
        var mockChildFactory: MockMessageFeedChildCoordinatorFactory!
        var invokeDidFinishCount: Int!

        beforeEach {
            mockRouter = MockRouter()
            mockRouter.shouldInvokeDismissPresentableCompletion = true

            mockViewModel = MockMessageFeedViewModel()
            mockViewModel.stubbedCurrentUserResult = User.stub(name: "Bob")

            mockPresentable = MockMessageFeedPresentable()
            mockAlert = MockAlertController(title: nil, message: nil, preferredStyle: .alert)
            mockPresentableFactory = MockMessageFeedPresentableFactory()

            mockPresentableFactory.stubbedMakeMessageFeedViewModelResult = mockViewModel
            mockPresentableFactory.stubbedMakeMessageFeedPresentableResult = mockPresentable

            mockAlert.stubbedTextFields = [UITextField(), UITextField()]
            mockAlert.stubbedTextFields?[0].text = "Woot!"
            mockAlert.stubbedTextFields?[1].text = "Boogy!"
            mockPresentableFactory.stubbedMakeAddMessageAlertPresentableResult = mockAlert
            mockPresentableFactory.stubbedMakeSignInAlertPresentableResult = mockAlert

            mockChildCoordinator = MockFilterPickerCoordinator()
            mockChildFactory = MockMessageFeedChildCoordinatorFactory()
            mockChildFactory.stubbedMakeFilterPickerCoordinatorResult = mockChildCoordinator

            sut = MessageFeedCoordinatorImplementation(router: mockRouter, presentableFactory: mockPresentableFactory, childFactory: mockChildFactory)

            invokeDidFinishCount = 0
            sut.didFinish = {
                invokeDidFinishCount += 1
            }
        }

        describe("a MessageFeedCoordinatorImplementation") {
            it("should be a type of MessageFeedCoordinator") {
                expect(sut).to(beAKindOf(MessageFeedCoordinator.self))
            }

            it("should be a type of BaseCoordinator") {
                expect(sut).to(beAKindOf(BaseCoordinator.self))
            }

            it("should be an instance of MessageFeedCoordinatorImplementation") {
                expect(sut).to(beAnInstanceOf(MessageFeedCoordinatorImplementation.self))
            }

            describe("start") {
                beforeEach {
                    sut.start()
                }

                it("should invoke makeMessageFeedViewModel on the presentable factory") {
                    expect(mockPresentableFactory.invokedMakeMessageFeedViewModelCount).to(equal(1))
                }

                it("should set the viewModel on the message feed presentable") {
                    expect(mockPresentable.invokedViewModelSetterCount).to(equal(1))
                }

                it("should set the delegate on the viewModel") {
                    expect(mockViewModel.invokedDelegateSetterCount).to(equal(1))
                }

                it("should set the presentable as the delegate on the viewModel") {
                    expect(mockViewModel.invokedDelegate).to(be(mockPresentable))
                }

                it("should invoke getAllMessages on the viewModel") {
                    expect(mockViewModel.invokedGetAllMessagesCount).to(equal(1))
                }

                it("should set didFinish on the message feed presentable") {
                    expect(mockPresentable.invokedDidFinishSetterCount).to(equal(1))
                }

                describe("when didFinish is invoked on the presentable") {
                    beforeEach {
                        mockPresentable.invokedDidFinish?()
                    }

                    it("should invoke didFinish on sut") {
                        expect(invokeDidFinishCount).to(equal(1))
                    }
                }

                it("should set didTapMessage on the message feed presentable") {
                    expect(mockPresentable.invokedDidTapAddMessageSetterCount).to(equal(1))
                }

                describe("when didTapMessage is invoked on the presentable") {
                    beforeEach {
                        mockAlert.reset()
                        mockPresentable.invokedDidTapAddMessage?()
                    }

                    it("should invoke makeAddMessageAlertPresentable on the presentable factory") {
                        expect(mockPresentableFactory.invokedMakeAddMessageAlertPresentableCount).to(equal(1))
                    }

                    it("should invoke addAction to the alert") {
                        expect(mockAlert.invokedAddActionCount).to(equal(2))
                    }

                    it("should add matching submit action to the alert") {
                        expect(mockAlert.actions.first?.title).to(equal("Submit"))
                    }

                    it("should add matching cancel action to the alert") {
                        expect(mockAlert.actions.last?.title).to(equal("Cancel"))
                    }

                    describe("when the submit action is invoked") {
                        beforeEach {
                            mockAlert.tapButton(atIndex: 0)
                        }

                        it("should invoked postMessage on the viewModel") {
                            expect(mockViewModel.invokedPostMessageCount).to(equal(1))
                        }
                    }

                    it("should invoke present on the message feed presentable") {
                        expect(mockPresentable.invokedPresentAnimatedCount).to(equal(1))
                    }

                    it("should invoke present with matching alert") {
                        expect(mockPresentable.invokedPresentAnimatedParameters?.presentable).to(be(mockAlert))
                    }
                }

                it("should set didTapSignIn on the message feed presentable") {
                    expect(mockPresentable.invokedDidTapSignInSetterCount).to(equal(1))
                }

                describe("when didTapSignIn is invoked") {
                    beforeEach {
                        mockPresentable.invokedDidTapSignIn?()
                    }

                    it("should invoke makeSignInAlertPresentable on the presentable factory") {
                        expect(mockPresentableFactory.invokedMakeSignInAlertPresentableCount).to(equal(1))
                    }

                    it("should add Let's Go! action to the alert") {
                        expect(mockAlert.actions.first?.title).to(equal("Let's Go!"))
                    }

                    it("should invoke present on the message feed presentable") {
                        expect(mockPresentable.invokedPresentAnimatedCount).to(equal(1))
                    }

                    it("should invoke present with a matching alert") {
                        expect(mockPresentable.invokedPresentAnimatedParameters?.presentable).to(be(mockAlert))
                    }

                    describe("when the action is invoked") {
                        context("when username is present") {
                            beforeEach {
                                mockAlert.tapButton(atIndex: 0)
                            }

                            it("should invoke signin on the viewModel") {
                                expect(mockViewModel.invokedSignInCount).to(equal(1))
                            }

                            it("should invoke signin with matching User") {
                                expect(mockViewModel.invokedSignInParameters?.user.name).to(equal("Woot!"))
                            }
                        }

                        context("if signin throws an error") {
                            beforeEach {
                                mockRouter = MockRouter()

                                mockViewModel = MockMessageFeedViewModel()
                                mockViewModel.stubbedCurrentUserResult = User.stub(name: "Bob")

                                mockViewModel.stubbedSignInError = MockError.stubError

                                mockPresentable = MockMessageFeedPresentable()
                                mockAlert = MockAlertController(title: nil, message: nil, preferredStyle: .alert)
                                mockPresentableFactory = MockMessageFeedPresentableFactory()

                                mockPresentableFactory.stubbedMakeMessageFeedViewModelResult = mockViewModel
                                mockPresentableFactory.stubbedMakeMessageFeedPresentableResult = mockPresentable

                                mockAlert.stubbedTextFields = [UITextField(), UITextField()]
                                mockAlert.stubbedTextFields?[0].text = "Woot!"
                                mockAlert.stubbedTextFields?[1].text = "Boogy!"
                                mockPresentableFactory.stubbedMakeAddMessageAlertPresentableResult = mockAlert
                                mockPresentableFactory.stubbedMakeSignInAlertPresentableResult = mockAlert

                                mockChildCoordinator = MockFilterPickerCoordinator()
                                mockChildFactory = MockMessageFeedChildCoordinatorFactory()
                                mockChildFactory.stubbedMakeFilterPickerCoordinatorResult = mockChildCoordinator

                                sut = MessageFeedCoordinatorImplementation(router: mockRouter, presentableFactory: mockPresentableFactory, childFactory: mockChildFactory)

                                sut.start()
                                mockPresentable.invokedDidTapSignIn?()
                                mockAlert.tapButton(atIndex: 0)
                            }

                            it("should invoke presentAlert on the message feed presentable") {
                                expect(mockPresentable.invokedPresentCount).to(equal(1))
                            }
                        }
                    }
                }

                it("should set didTapFilterMessages on the message feed presentable") {
                    expect(mockPresentable.invokedDidTapFilterMessagesSetterCount).to(equal(1))
                }

                describe("when didTapFilterMessages is invoked") {
                    let stubNames = ["Savannah", "Morrison"]

                    beforeEach {
                        mockPresentable.invokedDidTapFilterMessages?(stubNames)
                    }

                    describe("when presentPicker with names is invoked") {
                        it("should invoke makeFilterPickerCoordinator on the child factory") {
                            expect(mockChildFactory.invokedMakeFilterPickerCoordinatorCount).to(equal(1))
                        }

                        it("should add a dependency") {
                            let child = sut.childCoordinators.first as? MockFilterPickerCoordinator

                            expect(child).toNot(beNil())
                        }

                        it("should set didFinish on the child coordinator") {
                            expect(mockChildCoordinator.invokedDidFinishSetterCount).to(equal(1))
                        }

                        describe("when didFinish is invoked on the child") {
                            beforeEach {
                                mockChildCoordinator.invokedDidFinish?("Zombiez")
                            }

                            it("should set a filterName on the viewModel") {
                                expect(mockViewModel.invokedFilterName).to(equal("Zombiez"))
                            }

                            it("should invoke dismissPresentable on the router") {
                                expect(mockRouter.invokedDismissPresentableCount).to(equal(1))
                            }

                            describe("when dismiss completes") {
                                it("should remove a dependency") {
                                    expect(sut.childCoordinators.contains(where: { type(of: $0) == MockFilterPickerCoordinator.self })).to(beFalse())
                                }
                            }
                        }

                        it("should invoke start with names on the child") {
                            expect(mockChildCoordinator.invokedStartWithCount).to(equal(1))
                        }
                    }
                }
            }
        }
    }
}
