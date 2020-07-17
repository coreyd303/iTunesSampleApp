//
//  AlbumDetailsViewControllerTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class AlbumDetailsViewControllerTests: QuickSpec {
    override func spec() {
        var sut: AlbumDetailsViewController!
        var mockViewModel: MockAlbumDetailsViewModel!
        var mockView: MockAlbumDetailsView!
        var invokedDidFinishCount: Int!
        var invokedRequestAlbumCount: Int!
        var invokedRequestAlbumParams: (url: String, Void)?
        var stubAlbum: Album!

        beforeEach {
            sut = AlbumDetailsViewController()

            stubAlbum = Album.stub()
            mockViewModel = MockAlbumDetailsViewModel()
            mockViewModel.stubbedAlbum = stubAlbum

            mockView = MockAlbumDetailsView()

            invokedDidFinishCount = 0
            sut.didFinish = {
                invokedDidFinishCount += 1
            }

            invokedRequestAlbumCount = 0
            invokedRequestAlbumParams = nil
            sut.didRequestAlbum = { url in
                invokedRequestAlbumCount += 1
                invokedRequestAlbumParams = (url, ())
            }

            sut.viewModel = mockViewModel

            UITestUtilities().setup(withViewController: sut)
        }

        describe("an AlbumDetailsViewController") {
            it("should be a type of AlbumDetailsPresentable") {
                expect(sut).to(beAKindOf(AlbumDetailsPresentable.self))
            }

            it("should be a type of alertablePresenter") {
                expect(sut).to(beAKindOf(AlertablePresenter.self))
            }

            it("should be an instance of AlbumDetailsViewController") {
                expect(sut).to(beAnInstanceOf(AlbumDetailsViewController.self))
            }

            it("should have a detailView") {
                expect(sut.detailView).to(beAKindOf(AlbumDetailsView.self))
            }

            describe("viewDidLoad") {
                describe("when applyDesign in invoked") {
                    it("should add a detailView") {
                        sut.viewDidLoad()
                        expect(sut.view.subviews.first).to(beAKindOf(AlbumDetailsView.self))
                    }
                }

                describe("when setup is invoked") {
                    beforeEach {
                        sut.detailView = mockView

                        sut.viewDidLoad()
                    }

                    it("should request an album from the view model") {
                        expect(mockViewModel.invokedAlbumGetterCount).to(equal(2))
                    }

                    context("when an album is present") {
                        it("should invoke configure on the view") {
                            expect(mockView.invokedConfigureCount).to(equal(1))
                        }
                    }

                    context("when an album is missing") {
                        beforeEach {
                            mockViewModel.stubbedAlbum = nil
                            sut.viewModel = mockViewModel

                            sut.viewDidLoad()
                        }

                        it("should invoke didFinish on sut") {
                            expect(invokedDidFinishCount).to(equal(1))
                        }
                    }

                    it("should set didFinish on the view") {
                        expect(mockView.invokedDidFinishSetterCount).to(equal(1))
                    }

                    describe("when didFinish is invoked on the view") {
                        beforeEach {
                            mockView.invokedDidFinish?()
                        }

                        it("should invoke didFinish on sut") {
                            expect(invokedDidFinishCount).to(equal(1))
                        }
                    }

                    it("should set didRequestAlbum on the view") {
                        expect(mockView.invokedDidRequestAlbumSetterCount).to(equal(1))
                    }

                    describe("when didRequestAlbum is invoked on the view") {
                        context("when a url is provided") {
                            beforeEach {
                                mockViewModel.stubbedItunesURL = "http://nowhere.com"

                                sut.detailView = mockView

                                UITestUtilities().setup(withViewController: sut)

                                sut.viewDidLoad()

                                mockView.invokedDidRequestAlbum?()
                            }

                            it("should invoke didRequestAlbum on sut") {
                                expect(invokedRequestAlbumCount).to(equal(1))
                            }

                            it("should invoke didRequestAlbum with matching url") {
                                expect(invokedRequestAlbumParams?.url).to(equal("http://nowhere.com"))
                            }
                        }

                        context("when a url is missing") {
                            beforeEach {
                                mockViewModel.stubbedItunesURL = nil
                                sut.viewModel = mockViewModel
                                sut.viewDidLoad()

                                mockView.invokedDidRequestAlbum?()
                            }

                            it("should present an alert on sut") {
                                expect(sut.presentedViewController).to(beAKindOf(UIAlertController.self))
                            }
                        }
                    }
                }
            }
        }
    }
}
