//
//  ItunesAlbumCoordinatorTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class ItunesAlbumCoordinatorTests: QuickSpec {
    override func spec() {
        var sut: ItunesAlbumCoordinatorImplementation!
        var invokedDidFinishCount: Int!

        beforeEach {
            sut = ItunesAlbumCoordinatorImplementation(url: URL(string: "http://nowhere.com")!)

            invokedDidFinishCount = 0
            sut.didFinish = {
                invokedDidFinishCount += 1
            }
        }

        describe("an ItunesAlbumCoordinator") {
            it("should be a type of ItunesAlbumCoordinator") {
                expect(sut).to(beAKindOf(ItunesAlbumCoordinator.self))
            }

            it("should be an instance of ItunesAlbumCoordinatorImplementation") {
                expect(sut).to(beAnInstanceOf(ItunesAlbumCoordinatorImplementation.self))
            }

            describe("start") {
                beforeEach {
                    sut.start()
                }

                it("should invoke didFinish on sut") {
                    expect(invokedDidFinishCount).to(equal(1))
                }
            }
        }
    }
}
