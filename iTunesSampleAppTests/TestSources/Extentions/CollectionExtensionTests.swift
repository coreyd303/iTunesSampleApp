//
//  CollectionExtensionTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class CollectionExtensionTests: QuickSpec {
    override func spec() {
        var collection: [String]!

        beforeEach {
            collection = ["Thing1"]
        }

        describe("safe index subscript") {
            it("should return a value if the subscript is within range") {
                expect(collection[safe: 0]).to(equal("Thing1"))
            }

            it("should return nil if the subscrip is out of range") {
                expect(collection[safe: 1]).to(beNil())
            }
        }
    }
}
