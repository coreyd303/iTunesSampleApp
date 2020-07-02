//
//  AppChildCoordinatorFactoryTests.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import CoordinatorSampleApp

class AppChildCoordinatorFactoryTests: QuickSpec {

    override func spec() {
        var sut: AppChildCoordinatorFactoryImplementation!
        var mockRouter: MockRouter!

        beforeEach {
            mockRouter = MockRouter()

            sut = AppChildCoordinatorFactoryImplementation(router: mockRouter)
        }

        describe("an AppChildCoordinatorFactory") {
            it("should be a type of AppChildCoordinatorFactory") {
                expect(sut).to(beAKindOf(AppChildCoordinatorFactory.self))
            }

            it("should be an instance of AppChildCoordinatorFactoryImplementation") {
                expect(sut).to(beAnInstanceOf(AppChildCoordinatorFactoryImplementation.self))
            }

            describe("makeStartupCoordinator") {
                var coordinator: StartupCoordinator!

                beforeEach {
                    coordinator = sut.makeStartupCoordinator()
                }

                it("should be a type of StartupCoordinator") {
                    expect(coordinator).to(beAKindOf(StartupCoordinator.self))
                }

                it("should be an instance of StarupCoordinatorImplementation") {
                    expect(coordinator).to(beAnInstanceOf(StarupCoordinatorImplementation.self))
                }
            }

            describe("makeMessageFeedCoordinator") {
                var coordinator: MessageFeedCoordinator!

                beforeEach {
                    coordinator = sut.makeMessageFeedCoordinator()
                }

                it("should be a type of MessageFeedCoordinator") {
                    expect(coordinator).to(beAKindOf(MessageFeedCoordinator.self))
                }

                it("should be an instance of MessageFeedCoordinatorImplementation") {
                    expect(coordinator).to(beAnInstanceOf(MessageFeedCoordinatorImplementation.self))
                }
            }
        }
    }
}
