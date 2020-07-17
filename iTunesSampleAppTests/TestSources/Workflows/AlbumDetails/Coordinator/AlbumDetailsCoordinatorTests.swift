//
//  AlbumDetailsCoordinatorTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import iTunesSampleApp

class AlbumDetailsCoordinatorTests: QuickSpec {
    override func spec() {
        var sut: AlbumDetailsCoordinatorImplementation!
        var mockRouter: MockRouter!
        var mockPresentable: MockAblumDetailsPresentable!
        var mockViewModel: MockAlbumDetailsViewModel!
        var mockPresentableFactory: MockAlbumDetailsPresentableFactory!
        var mockChildCoord: MockItunesCoordinator!
        var mockChildFactory: MockAlbumDetailsChildCoordinatorFactory!
        var stubAlbum: Album!
        var invokedDidFinishCount: Int!

        beforeEach {
            mockRouter = MockRouter()

            mockPresentable = MockAblumDetailsPresentable()
            mockPresentableFactory = MockAlbumDetailsPresentableFactory()
            mockPresentableFactory.stubbedMakeAlbumDetailsPresentableResult = mockPresentable
            mockViewModel = MockAlbumDetailsViewModel()
            mockPresentableFactory.stubbedMakeAlbumDetailsViewModelResult = mockViewModel

            mockChildCoord = MockItunesCoordinator()
            mockChildFactory = MockAlbumDetailsChildCoordinatorFactory()
            mockChildFactory.stubbedMakeItunesCoordinatorResult = mockChildCoord

            stubAlbum = Album.stub()

            sut = AlbumDetailsCoordinatorImplementation(router: mockRouter, presentableFactory: mockPresentableFactory, childCoordinatorFactory: mockChildFactory)

            invokedDidFinishCount = 0
            sut.didFinish = {
                invokedDidFinishCount += 1
            }
        }

        describe("an AlbumDetailsCoordinator") {
            it("should be a type of AlbumDetailsCoordinator") {
                expect(sut).to(beAKindOf(AlbumDetailsCoordinator.self))
            }

            it("should be a type of BaseCoordinator") {
                expect(sut).to(beAKindOf(BaseCoordinator.self))
            }

            it("should be an instance of AlbumDetailsCoordinatorImplementation") {
                expect(sut).to(beAnInstanceOf(AlbumDetailsCoordinatorImplementation.self))
            }

            describe("start with album") {
                beforeEach {
                    sut.start(with: stubAlbum)
                }

                it("should invoke makeAlbumDetailsPresentable on the presentable factory") {
                    expect(mockPresentableFactory.invokedMakeAlbumDetailsPresentableCount).to(equal(1))
                }

                it("should set didFinish on the presentable") {
                    expect(mockPresentable.invokedDidFinishSetterCount).to(equal(1))
                }

                describe("when didFinish is invoked") {
                    beforeEach {
                        mockPresentable.invokedDidFinish?()
                    }

                    it("should invoke pop on the router") {
                        expect(mockRouter.invokedPopCount).to(equal(1))
                    }

                    it("should invoke didFinish on sut") {
                        expect(invokedDidFinishCount).to(equal(1))
                    }
                }

                it("should set didRequestAlbum on the presentable") {
                    expect(mockPresentable.invokedDidRequestAlbumSetterCount).to(equal(1))
                }

                describe("when didRequestAlbum is invoked") {
                    beforeEach {
                        mockPresentable.invokedDidRequestAlbum?("http://nowhere.com")
                    }

                    describe("presentAlbum") {
                        it("should invoke makeItunesCoordinator on the childFactory") {
                            expect(mockChildFactory.invokedMakeItunesCoordinatorCount).to(equal(1))
                        }

                        it("should add a dependency") {
                            expect(sut.childCoordinators.first).to(beAKindOf(ItunesAlbumCoordinator.self))
                        }

                        it("should set didFinish on the child") {
                            expect(mockChildCoord.invokedDidFinishSetterCount).to(equal(1))
                        }

                        describe("when didFinish is invoked on the child") {
                            beforeEach {
                                mockChildCoord.invokedDidFinish?()
                            }

                            it("should remove a dependency") {
                                expect(sut.childCoordinators.contains(where: { type(of: $0) == ItunesAlbumCoordinator.self })).to(beFalse())
                            }
                        }

                        it("should invoke start on the child") {
                            expect(mockChildCoord.invokedStartCount).to(equal(1))
                        }
                    }
                }

                it("should invoked makeAlbumDetailsViewModel on the presentableFactory") {
                    expect(mockPresentableFactory.invokedMakeAlbumDetailsViewModelCount).to(equal(1))
                }

                it("should invoke makeAlbumDetailsViewModel with matching album") {
                    expect(mockPresentableFactory.invokedMakeAlbumDetailsViewModelParameters?.album).to(equal(stubAlbum))
                }

                it("should set the viewModel on the presentable") {
                    expect(mockPresentable.invokedViewModelSetterCount).to(equal(1))
                }

                describe("when start is invoked") {
                    it("should invoke push on the router") {
                        expect(mockRouter.invokedPushCount).to(equal(1))
                    }

                    it("should invoke push with a matching presentable") {
                        expect(mockRouter.invokedPushParameters?.presentable).to(be(mockPresentable))
                    }
                }
            }
        }
    }
}
