//
//  AlbumDetailsPresentableFactoryTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class AlbumDetailsPresentableFactoryTests: QuickSpec {
    override func spec() {
        var sut: AlbumDetailsPresentableFactoryImplementation!

        beforeEach {
            sut = AlbumDetailsPresentableFactoryImplementation()
        }

        describe("an AlbumDetailsPresentableFactory") {
            it("should be a type of AlbumDetailsPresentableFactory") {
                expect(sut).to(beAKindOf(AlbumDetailsPresentableFactory.self))
            }

            it("should be an instance of AlbumDetailsPresentableFactoryImplementation") {
                expect(sut).to(beAnInstanceOf(AlbumDetailsPresentableFactoryImplementation.self))
            }

            describe("makeAlbumDetailsPresentable") {
                var presentable: AlbumDetailsPresentable!

                beforeEach {
                    presentable = sut.makeAlbumDetailsPresentable()
                }

                it("should return a type of AlbumDetailsPresentable") {
                    expect(presentable).to(beAKindOf(AlbumDetailsPresentable.self))
                }

                it("should return an instance of AlbumDetailsViewController") {
                    expect(presentable).to(beAnInstanceOf(AlbumDetailsViewController.self))
                }

            }

            describe("makeAlbumDetailsViewModel") {
                var viewModel: AlbumDetailsViewModel!
                var stubAlbum: Album!

                beforeEach {
                    stubAlbum = Album.stub()
                    viewModel = sut.makeAlbumDetailsViewModel(album: stubAlbum)
                }

                it("should return a type of AlbumDetailsViewModel") {
                    expect(viewModel).to(beAKindOf(AlbumDetailsViewModel.self))
                }

                it("should return an instance of AlbumDetailsViewModelImplementation") {
                    expect(viewModel).to(beAnInstanceOf(AlbumDetailsViewModelImplementation.self))
                }

                it("should provide a matching album to the viewModel") {
                    expect(viewModel.album).to(equal(stubAlbum))
                }
            }
        }
    }
}
