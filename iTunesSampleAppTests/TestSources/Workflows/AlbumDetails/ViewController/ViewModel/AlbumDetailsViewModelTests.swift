//
//  AlbumDetailsViewModelTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class AlbumDetailsViewModelTests: QuickSpec {
    override func spec() {
        var sut: AlbumDetailsViewModel!
        var stubAlbum: Album!

        beforeEach {
            stubAlbum = Album.stub(url: "http://rockOn.com")
            sut = AlbumDetailsViewModelImplementation(album: stubAlbum)
        }

        describe("an AlbumDetailsViewModel") {
            it("should be a type of AlbumDetailsViewModel") {
                expect(sut).to(beAKindOf(AlbumDetailsViewModel.self))
            }

            it("should be an instance of AlbumDetailsViewModelImplementation") {
                expect(sut).to(beAnInstanceOf(AlbumDetailsViewModelImplementation.self))
            }

            describe("itunesURL") {
                it("should provide a matching url") {
                    expect(sut.itunesURL).to(equal(stubAlbum.url))
                }
            }
        }
    }
}
