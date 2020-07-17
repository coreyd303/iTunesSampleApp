//
//  QueueTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class QueueTests: QuickSpec {
    override func spec() {
        var sut: Queue!
        var didComplete: Bool!

        beforeEach {
            didComplete = false
            sut = Queue()
        }

        describe("a Queue") {
            it("should complete async on global") {
                sut.async {
                    didComplete = true
                }

                expect(didComplete).toEventually(beTrue(), timeout: 10)
            }

            it("should complete async on main") {
                sut.main {
                    didComplete = true
                }

                expect(didComplete).toEventually(beTrue())
            }
        }
    }
}
