//
//  AppCoordinatorTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class AppCoordinatorTests: QuickSpec {

    override func spec() {
        var sut: AppCoordinatorImplementation!
        var mockWindow: MockWindowProviding!
        var mockRouter: MockRouter!
        var mockFactory: MockAppChildCoordinatorFactory!
        var mockStartupCoord: MockStartupCoordinator!
        var mockMusicCoord: MockMusicFeedCoordinator!

        beforeEach {
            mockWindow = MockWindowProviding()
            mockRouter = MockRouter()

            mockStartupCoord = MockStartupCoordinator()
            mockMusicCoord = MockMusicFeedCoordinator()

            mockFactory = MockAppChildCoordinatorFactory()
            mockFactory.stubbedMakeStartupCoordinatorResult = mockStartupCoord
            mockFactory.stubbedMakeMusicFeedCoordinatorResult = mockMusicCoord

            sut = AppCoordinatorImplementation(window: mockWindow, router: mockRouter, childFactory: mockFactory, appState: .launching)
        }

        describe("an AppCoordinatorImplementation") {
            it("should be a type of AppCoordinator") {
                expect(sut).to(beAKindOf(AppCoordinator.self))
            }

            it("should be an instance of AppCoordinatorImplementation") {
                expect(sut).to(beAnInstanceOf(AppCoordinatorImplementation.self))
            }

            describe("start") {
                beforeEach {
                    sut.start()
                }

                it("should invoke setRootPresentable on the window") {
                    expect(mockWindow.invokedSetRootPresentableCount).to(equal(1))
                }

                it("should invoke setRootPresentable with a matching presentable") {
                    expect(mockWindow.invokedSetRootPresentableParameters?.presentable).to(be(mockRouter))
                }

                describe("when present with appState is invoked") {
                    context("when appState is .launching") {

                        it("should invoked makeStartupCoordinator on the childFactory") {
                            expect(mockFactory.invokedMakeStartupCoordinatorCount).to(equal(1))
                        }

                        it("should add a coordinator dependency") {
                            let child = sut.childCoordinators.first as? MockStartupCoordinator

                            expect(child).toNot(beNil())
                        }

                        it("should invoke didFinish setter on the childCoordinator") {
                            expect(mockStartupCoord.invokedDidFinishSetterCount).to(equal(1))
                        }

                        it("should invoke start on the childCoordinator") {
                            expect(mockStartupCoord.invokedStartCount).to(equal(1))
                        }

                        describe("when didFinish is invoked on the child coordinator") {

                            beforeEach {
                                mockStartupCoord.invokedDidFinish?()
                            }

                            it("should remove a coordinator dependency") {
                                expect(sut.childCoordinators.contains(where: { type(of: $0) == MockStartupCoordinator.self })).to(beFalse())
                            }

                            it("should update appState to be .main") {
                                expect(sut.appState).to(equal(.main))
                            }
                        }
                    }

                    context("when appState is .main") {
                        beforeEach {
                            sut = AppCoordinatorImplementation(window: mockWindow, router: mockRouter, childFactory: mockFactory, appState: .main)

                            sut.start()
                        }

                        it("should invoke makeMusicFeedCoordinator on the childFactory") {
                            expect(mockFactory.invokedMakeMusicFeedCoordinatorCount).to(equal(1))
                        }

                        it("should add a coordinator dependency") {
                            let child = sut.childCoordinators.first as? MockMusicFeedCoordinator

                            expect(child).toNot(beNil())
                        }

                        it("should set didFinish on the childCoordinator") {
                            expect(mockMusicCoord.invokedDidFinishSetterCount).to(equal(1))
                        }

                        it("should invoke start on the childCoordinator") {
                            expect(mockMusicCoord.invokedStartCount).to(equal(1))
                        }

                        describe("when didFinish is invoked on the child coordinator") {

                            beforeEach {
                                mockMusicCoord.invokedDidFinish?()
                            }

                            it("should remove a coordinator dependency") {
                                expect(sut.childCoordinators.contains(where: { type(of: $0) == MockMusicFeedCoordinator.self })).to(beFalse())
                            }
                        }
                    }
                }
            }
        }
    }
}
