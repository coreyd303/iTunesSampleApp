//
//  MessageFeedChildCoordinatorFactoryTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import LoveverySampleApp

class MessageFeedChildCoordinatorFactoryTests: QuickSpec {
    override func spec() {
        var sut: MessageFeedChildCoordinatorFactoryImplementation!

        beforeEach {
            sut = MessageFeedChildCoordinatorFactoryImplementation(router: MockRouter())
        }

        describe("a MessageFeedChildCoordinatorFactoryImplementation") {
            it("should be a type of MessageFeedChildCoordinatorFactory") {
                expect(sut).to(beAKindOf(MessageFeedChildCoordinatorFactory.self))
            }

            it("should be an instance of MessageFeedChildCoordinatorFactoryImplementation") {
                expect(sut).to(beAnInstanceOf(MessageFeedChildCoordinatorFactoryImplementation.self))
            }

            describe("makeFilterPickerCoordinator") {
                var coordinator: FilterPickerCoordinator!

                beforeEach {
                    coordinator = sut.makeFilterPickerCoordinator()
                }

                it("should be a type of FilterPickerCoordinator") {
                    expect(coordinator).to(beAKindOf(FilterPickerCoordinator.self))
                }

                it("should be an instance of FilterPickerCoordinatorImplementation") {
                    expect(coordinator).to(beAnInstanceOf(FilterPickerCoordinatorImplementation.self))
                }
            }
        }
    }
}
