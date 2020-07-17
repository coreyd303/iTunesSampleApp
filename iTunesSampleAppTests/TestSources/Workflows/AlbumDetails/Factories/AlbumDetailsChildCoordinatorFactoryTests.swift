//
//  AlbumDetailsChildCoordinatorFactoryTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class AlbumDetailsChildCoordinatorFactoryTests: QuickSpec {
    override func spec() {
        var sut: AlbumDetailsChildCoordinatorFactoryImplementation!

        beforeEach {
            sut = AlbumDetailsChildCoordinatorFactoryImplementation()
        }

        describe("an AlbumDetailsChildCoordinatorFactory") {
            it("should be a type of AlbumDetailsChildCoordinatorFactory") {
                expect(sut).to(beAKindOf(AlbumDetailsChildCoordinatorFactory.self))
            }

            it("should be an instance of AlbumDetailsChildCoordinatorFactoryImplementation") {
                expect(sut).to(beAnInstanceOf(AlbumDetailsChildCoordinatorFactoryImplementation.self))
            }

            describe("makeItunesCoordinator") {
                var child: ItunesAlbumCoordinator!
                var stubURL: URL!

                beforeEach {
                    stubURL = URL(string: "http://nowhere.com")!
                    child = sut.makeItunesCoordinator(url: stubURL)
                }

                it("should return a type of ItunesAlbumCoordinator") {
                    expect(child).to(beAKindOf(ItunesAlbumCoordinator.self))
                }

                it("should return an instance of ItunesAlbumCoordinatorImplementation") {
                    expect(child).to(beAnInstanceOf(ItunesAlbumCoordinatorImplementation.self))
                }
            }
        }
    }
}
