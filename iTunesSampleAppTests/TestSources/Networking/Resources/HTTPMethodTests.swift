//
//  HTTPMethodTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class HTTPMethodTests: QuickSpec {
    override func spec() {
        var sut: HTTPMethod!

        describe("an HTTPMethod") {
            it("should be GET") {
                sut = .get
                expect(sut.rawValue).to(equal("GET"))
            }

            it("should be POST") {
                sut = .post
                expect(sut.rawValue).to(equal("POST"))
            }
        }
    }
}

