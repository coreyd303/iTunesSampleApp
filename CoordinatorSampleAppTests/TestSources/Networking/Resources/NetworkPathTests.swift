//
//  NetworkPathTests.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import CoordinatorSampleApp

class NetworkPathTests: QuickSpec {
    override func spec() {
        var sut: NetworkPath!

        describe("a NetworkPath") {
            describe("description") {
                it("should be when .getMessges") {
                    sut = .getMessages(.none)
                    expect(sut.description).to(equal("/messages/"))
                }

                it("should be when .getMessges($userName)") {
                    sut = .getMessages("robby")
                    expect(sut.description).to(equal("/messages/robby"))
                }

                it("should be when .postMessages") {
                    sut = .postMessage
                    expect(sut.description).to(equal("/messages"))
                }
            }
        }
    }
}
