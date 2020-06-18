//
//  RequestDataTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import LoveverySampleApp

class RequestDataTests: QuickSpec {
    override func spec() {
        var stubData: Data!
        var sut: RequestData!

        beforeEach {
            stubData = Data(base64Encoded: "WOOT")

            sut = RequestData(path: .getMessages(.none), method: .get, body: stubData)
        }

        describe("a RequestData") {
            it("should have a matching path") {
                expect(sut.path).to(equal("https://abraxvasbh.execute-api.us-east-2.amazonaws.com/proto/messages/"))
            }

            it("should have a matching method") {
                expect(sut.method).to(equal(.get))
            }

            it("should have matching body") {
                expect(sut.body).to(equal(stubData))
            }
        }
    }
}
