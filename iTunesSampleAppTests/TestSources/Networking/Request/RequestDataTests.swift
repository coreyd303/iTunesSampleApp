//
//  RequestDataTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class RequestDataTests: QuickSpec {
    override func spec() {
        var sut: RequestData!

        beforeEach {
            sut = RequestData(path: .getMusic(feedType: "Any", genre: "Any", limit: 1, allowExplicit: true))
        }

        describe("a RequestData") {
            it("should have a matching path") {
                expect(sut.path).to(equal("https://rss.itunes.apple.com/api/v1/us/apple-music/Any/Any/1/true.json"))
            }

            it("should have a matching method") {
                expect(sut.method).to(equal(.get))
            }
        }
    }
}
