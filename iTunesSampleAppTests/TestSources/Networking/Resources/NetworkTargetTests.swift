//
//  NetworkTargetTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class NetworkTests: QuickSpec {
    override func spec() {
        describe("a NetworkTarget") {
            it("should return a baseURL") {
                expect(NetworkTarget.baseURL).to(equal("https://rss.itunes.apple.com/api/v1/us/apple-music"))
            }
        }
    }
}
