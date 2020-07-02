//
//  BasePresentableFactoryTests.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import CoordinatorSampleApp

class BasePresentableFactoryTests: QuickSpec {
    override func spec() {
        describe("BasePresentableFactoryImplementation") {
            var sut: BasePresentableFactoryImplementation!

            beforeEach {
                sut = BasePresentableFactoryImplementation()
            }

            describe("makeRouter") {

                it("should return a type of Router") {
                    expect(sut.makeRouter()).to(beAKindOf(Router.self))
                }

                it("should return an instance of RouterImplementation") {
                    expect(sut.makeRouter()).to(beAKindOf(RouterImplementation.self))
                }
            }
        }
    }
}
