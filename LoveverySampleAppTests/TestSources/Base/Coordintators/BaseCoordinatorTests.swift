//
//  BaseCoordinatorTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import LoveverySampleApp

class BaseCoordinatorTests: QuickSpec {
    override func spec() {
        var sut: BaseCoordinator!
        var dependency1: MockCoordinator!
        var dependency2: MockCoordinator!

        beforeEach {
            sut = BaseCoordinator()
            dependency1 = MockCoordinator()
            dependency2 = MockCoordinator()
            dependency2.referenceValue = 1
        }

        describe("BaseCoordinator") {
            describe("start") {
                context("baseCoordinator must be subclassed") {
                    it("should fail with proper message") {
                        expect { sut.start() }.to(throwAssertion())
                    }
                }
            }

            describe("addDependency") {
                context("when adding a unique coordinator as a dependency") {
                    it("should add a dependency") {
                        sut.addDependency(dependency1)

                        expect(sut.childCoordinators.first).to(be(dependency1))
                    }

                    it("should add multiple dependencies") {
                        sut.addDependency(dependency1)
                        sut.addDependency(dependency2)

                        expect(sut.childCoordinators.count).to(equal(2))
                    }
                }

                context("when trying to add an already contained coordinator as a dependency") {
                    it("should not add the same dependency") {
                        sut.addDependency(dependency1)
                        sut.addDependency(dependency1)

                        expect(sut.childCoordinators.count).to(equal(1))
                    }
                }
            }

            describe("removeDependency") {
                it("should remove a dependency") {
                    sut.addDependency(dependency1)

                    sut.removeDependency(dependency1)
                    expect(sut.childCoordinators.count).to(equal(0))
                }

                context("when there are multiple child dependencies") {
                    it("should only remove the correct dependency") {
                        sut.addDependency(dependency1)
                        sut.addDependency(dependency2)

                        sut.removeDependency(dependency1)
                        expect(sut.childCoordinators.first).to(be(dependency2))
                    }
                }

                context("when child coordinators have dependencies") {
                    it("should invoke remove dependency for child coordinators which are also baseCoordinators") {
                        let mockBaseCoordinator = MockBaseCoordinator()
                        mockBaseCoordinator.stubbedChildCoordinators = [dependency1]
                        sut.addDependency(mockBaseCoordinator)

                        sut.removeDependency(mockBaseCoordinator)
                        expect(mockBaseCoordinator.invokedRemoveDependencyCount).to(equal(1))
                    }
                }
            }
        }
    }
}

