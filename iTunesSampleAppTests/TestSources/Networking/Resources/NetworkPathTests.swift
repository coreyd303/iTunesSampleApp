//
//  NetworkPathTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class NetworkPathTests: QuickSpec {
    override func spec() {
        var sut: NetworkPath!

        describe("a NetworkPath") {
            describe("description") {
                it("should be when .getMessges") {
                    sut = .getMusic(feedType: "Top", genre: "Rock", limit: 10, allowExplicit: true)
                    expect(sut.description).to(equal("/Top/Rock/10/true.json"))
                }
            }
        }
    }
}
