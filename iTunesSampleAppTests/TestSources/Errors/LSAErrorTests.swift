//
//  SAErrorTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class SAErrorTests: QuickSpec {
    override func spec() {

        var error: SAError!

        describe("createError with description") {

            beforeEach {
                error = createError("rut roe")
            }

            it("should be a type of Error") {
                expect(error).to(beAKindOf(Error.self))
            }

            it("should be an instance of SAError") {
                expect(error).to(beAnInstanceOf(SAError.self))
            }

            it("should have a matching description") {
                expect(error.localizedDescription).to(equal("rut roe"))
            }
        }

        describe("createError with errorCode") {
            context("when code is 400") {
                beforeEach {
                    error = createError(400)
                }

                it("should be a type of Error") {
                    expect(error).to(beAKindOf(Error.self))
                }

                it("should be an instance of SAError") {
                    expect(error).to(beAnInstanceOf(SAError.self))
                }

                it("should have a matching description") {
                    expect(error.localizedDescription).to(equal("invalidRequest"))
                }
            }

            context("when code is 404") {
                beforeEach {
                    error = createError(404)
                }

                it("should be a type of Error") {
                    expect(error).to(beAKindOf(Error.self))
                }

                it("should be an instance of SAError") {
                    expect(error).to(beAnInstanceOf(SAError.self))
                }

                it("should have a matching description") {
                    expect(error.localizedDescription).to(equal("notFound"))
                }
            }

            context("when code is 500") {
                beforeEach {
                    error = createError(500)
                }

                it("should be a type of Error") {
                    expect(error).to(beAKindOf(Error.self))
                }

                it("should be an instance of SAError") {
                    expect(error).to(beAnInstanceOf(SAError.self))
                }

                it("should have a matching description") {
                    expect(error.localizedDescription).to(equal("serverError"))
                }
            }

            context("when code is unknown") {
                beforeEach {
                    error = createError(000)
                }

                it("should be a type of Error") {
                    expect(error).to(beAKindOf(Error.self))
                }

                it("should be an instance of SAError") {
                    expect(error).to(beAnInstanceOf(SAError.self))
                }

                it("should have a matching description") {
                    expect(error.localizedDescription).to(equal("unknownError"))
                }
            }
        }
    }
}
