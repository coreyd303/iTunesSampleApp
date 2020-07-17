//
//  AlbumDetailsViewTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import iTunesSampleApp

class AlbumDetailsViewTests: QuickSpec {
    override func spec() {
        var sut: AlbumDetailsView!
        var stubAlbum: Album!
        var mockImageView: MockCachedImageView!
        var invokedDidFinishCount: Int!
        var invokedDidRequestAlbumCount: Int!

        beforeEach {
            stubAlbum = Album.stub(name: "Dark all day", artistName: "GUNSHIP", artworkUrl100: "http://anywhere.com", releaseDate: "today", copyright: "woot an woot", url: "http://nowhere.com", genres: [Genre.stub(name: "awesome")])

            sut = AlbumDetailsView()

            mockImageView = MockCachedImageView()
            sut.coverImage = mockImageView

            invokedDidFinishCount = 0
            sut.didFinish = {
                invokedDidFinishCount += 1
            }

            invokedDidRequestAlbumCount = 0
            sut.didRequestAlbum = {
                invokedDidRequestAlbumCount += 1
            }
        }

        describe("an AlbumDetailsView") {
            it("should be a type of UIView") {
                expect(sut).to(beAKindOf(UIView.self))
            }

            it("should be an instance of AlbumDetailsView") {
                expect(sut).to(beAnInstanceOf(AlbumDetailsView.self))
            }

            describe("configure") {
                context("when an album is missing") {
                    it("should invoke didFinish on sut") {
                        sut.configure(with: nil)
                        expect(invokedDidFinishCount).to(equal(1))
                    }
                }

                context("when an album is present") {
                    beforeEach {
                        sut.configure(with: stubAlbum)
                    }

                    it("should invoke setImage on the coverImage") {
                        expect(mockImageView.invokedSetImageCount).to(equal(1))
                    }

                    it("should invoke setImage with matching url") {
                        expect(mockImageView.invokedSetImageParameters?.url).to(equal(URL(string: stubAlbum.artworkUrl100)))
                    }

                    it("should set matching text on the albumTitleLabel") {
                        expect(sut.albumTitleLabel.text).to(equal(stubAlbum.name))
                    }

                    it("should set matching text on the artistLabel") {
                        expect(sut.artistLabel.text).to(equal(stubAlbum.artistName))
                    }

                    it("should set matching text on the genreLabel") {
                        expect(sut.genreLabel.text).to(equal(stubAlbum.genres.first?.name))
                    }

                    it("should set matching text on the releaseLabel") {
                        expect(sut.releaseLabel.text).to(equal(stubAlbum.releaseDate))
                    }

                    it("should set matching text on the copyrightLabel") {
                        expect(sut.copyrightLabel.text).to(equal(stubAlbum.copyright))
                    }
                }
            }

            describe("didTapItunesButton") {
                beforeEach {
                    sut.didTapItunesButton(UIButton())
                }

                it("should invoke didRequestAlbum on sut") {
                    expect(invokedDidRequestAlbumCount).to(equal(1))
                }
            }
        }
    }
}
