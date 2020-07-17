//
//  MockAlbumDetailView.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import iTunesSampleApp

class MockAlbumDetailsView: AlbumDetailsView {
    var invokedDidFinishSetter = false
    var invokedDidFinishSetterCount = 0
    var invokedDidFinish: (() -> ())?
    var invokedDidFinishList = [(() -> ())?]()
    var invokedDidFinishGetter = false
    var invokedDidFinishGetterCount = 0
    var stubbedDidFinish: (() -> ())!
    override var didFinish: (() -> ())? {
        set {
            invokedDidFinishSetter = true
            invokedDidFinishSetterCount += 1
            invokedDidFinish = newValue
            invokedDidFinishList.append(newValue)
        }
        get {
            invokedDidFinishGetter = true
            invokedDidFinishGetterCount += 1
            return stubbedDidFinish
        }
    }
    var invokedDidRequestAlbumSetter = false
    var invokedDidRequestAlbumSetterCount = 0
    var invokedDidRequestAlbum: (() -> ())?
    var invokedDidRequestAlbumList = [(() -> ())?]()
    var invokedDidRequestAlbumGetter = false
    var invokedDidRequestAlbumGetterCount = 0
    var stubbedDidRequestAlbum: (() -> ())!
    override var didRequestAlbum: (() -> ())? {
        set {
            invokedDidRequestAlbumSetter = true
            invokedDidRequestAlbumSetterCount += 1
            invokedDidRequestAlbum = newValue
            invokedDidRequestAlbumList.append(newValue)
        }
        get {
            invokedDidRequestAlbumGetter = true
            invokedDidRequestAlbumGetterCount += 1
            return stubbedDidRequestAlbum
        }
    }
    var invokedContainerSetter = false
    var invokedContainerSetterCount = 0
    var invokedContainer: UIView?
    var invokedContainerList = [UIView]()
    var invokedContainerGetter = false
    var invokedContainerGetterCount = 0
    var stubbedContainer: UIView!
    override var container: UIView {
        set {
            invokedContainerSetter = true
            invokedContainerSetterCount += 1
            invokedContainer = newValue
            invokedContainerList.append(newValue)
        }
        get {
            invokedContainerGetter = true
            invokedContainerGetterCount += 1
            return stubbedContainer
        }
    }
    var invokedCoverImageSetter = false
    var invokedCoverImageSetterCount = 0
    var invokedCoverImage: CachedImageView?
    var invokedCoverImageList = [CachedImageView]()
    var invokedCoverImageGetter = false
    var invokedCoverImageGetterCount = 0
    var stubbedCoverImage: CachedImageView!
    override var coverImage: CachedImageView {
        set {
            invokedCoverImageSetter = true
            invokedCoverImageSetterCount += 1
            invokedCoverImage = newValue
            invokedCoverImageList.append(newValue)
        }
        get {
            invokedCoverImageGetter = true
            invokedCoverImageGetterCount += 1
            return stubbedCoverImage
        }
    }
    var invokedContentStackSetter = false
    var invokedContentStackSetterCount = 0
    var invokedContentStack: UIStackView?
    var invokedContentStackList = [UIStackView]()
    var invokedContentStackGetter = false
    var invokedContentStackGetterCount = 0
    var stubbedContentStack: UIStackView!
    override var contentStack: UIStackView {
        set {
            invokedContentStackSetter = true
            invokedContentStackSetterCount += 1
            invokedContentStack = newValue
            invokedContentStackList.append(newValue)
        }
        get {
            invokedContentStackGetter = true
            invokedContentStackGetterCount += 1
            return stubbedContentStack
        }
    }
    var invokedHorizontalStackSetter = false
    var invokedHorizontalStackSetterCount = 0
    var invokedHorizontalStack: UIStackView?
    var invokedHorizontalStackList = [UIStackView]()
    var invokedHorizontalStackGetter = false
    var invokedHorizontalStackGetterCount = 0
    var stubbedHorizontalStack: UIStackView!
    override var horizontalStack: UIStackView {
        set {
            invokedHorizontalStackSetter = true
            invokedHorizontalStackSetterCount += 1
            invokedHorizontalStack = newValue
            invokedHorizontalStackList.append(newValue)
        }
        get {
            invokedHorizontalStackGetter = true
            invokedHorizontalStackGetterCount += 1
            return stubbedHorizontalStack
        }
    }
    var invokedAlbumTitleLabelSetter = false
    var invokedAlbumTitleLabelSetterCount = 0
    var invokedAlbumTitleLabel: UILabel?
    var invokedAlbumTitleLabelList = [UILabel]()
    var invokedAlbumTitleLabelGetter = false
    var invokedAlbumTitleLabelGetterCount = 0
    var stubbedAlbumTitleLabel: UILabel!
    override var albumTitleLabel: UILabel {
        set {
            invokedAlbumTitleLabelSetter = true
            invokedAlbumTitleLabelSetterCount += 1
            invokedAlbumTitleLabel = newValue
            invokedAlbumTitleLabelList.append(newValue)
        }
        get {
            invokedAlbumTitleLabelGetter = true
            invokedAlbumTitleLabelGetterCount += 1
            return stubbedAlbumTitleLabel
        }
    }
    var invokedArtistLabelSetter = false
    var invokedArtistLabelSetterCount = 0
    var invokedArtistLabel: UILabel?
    var invokedArtistLabelList = [UILabel]()
    var invokedArtistLabelGetter = false
    var invokedArtistLabelGetterCount = 0
    var stubbedArtistLabel: UILabel!
    override var artistLabel: UILabel {
        set {
            invokedArtistLabelSetter = true
            invokedArtistLabelSetterCount += 1
            invokedArtistLabel = newValue
            invokedArtistLabelList.append(newValue)
        }
        get {
            invokedArtistLabelGetter = true
            invokedArtistLabelGetterCount += 1
            return stubbedArtistLabel
        }
    }
    var invokedGenreLabelSetter = false
    var invokedGenreLabelSetterCount = 0
    var invokedGenreLabel: UILabel?
    var invokedGenreLabelList = [UILabel]()
    var invokedGenreLabelGetter = false
    var invokedGenreLabelGetterCount = 0
    var stubbedGenreLabel: UILabel!
    override var genreLabel: UILabel {
        set {
            invokedGenreLabelSetter = true
            invokedGenreLabelSetterCount += 1
            invokedGenreLabel = newValue
            invokedGenreLabelList.append(newValue)
        }
        get {
            invokedGenreLabelGetter = true
            invokedGenreLabelGetterCount += 1
            return stubbedGenreLabel
        }
    }
    var invokedReleaseLabelSetter = false
    var invokedReleaseLabelSetterCount = 0
    var invokedReleaseLabel: UILabel?
    var invokedReleaseLabelList = [UILabel]()
    var invokedReleaseLabelGetter = false
    var invokedReleaseLabelGetterCount = 0
    var stubbedReleaseLabel: UILabel!
    override var releaseLabel: UILabel {
        set {
            invokedReleaseLabelSetter = true
            invokedReleaseLabelSetterCount += 1
            invokedReleaseLabel = newValue
            invokedReleaseLabelList.append(newValue)
        }
        get {
            invokedReleaseLabelGetter = true
            invokedReleaseLabelGetterCount += 1
            return stubbedReleaseLabel
        }
    }
    var invokedCopyrightLabelSetter = false
    var invokedCopyrightLabelSetterCount = 0
    var invokedCopyrightLabel: UILabel?
    var invokedCopyrightLabelList = [UILabel]()
    var invokedCopyrightLabelGetter = false
    var invokedCopyrightLabelGetterCount = 0
    var stubbedCopyrightLabel: UILabel!
    override var copyrightLabel: UILabel {
        set {
            invokedCopyrightLabelSetter = true
            invokedCopyrightLabelSetterCount += 1
            invokedCopyrightLabel = newValue
            invokedCopyrightLabelList.append(newValue)
        }
        get {
            invokedCopyrightLabelGetter = true
            invokedCopyrightLabelGetterCount += 1
            return stubbedCopyrightLabel
        }
    }
    var invokedItunesButtonSetter = false
    var invokedItunesButtonSetterCount = 0
    var invokedItunesButton: UIButton?
    var invokedItunesButtonList = [UIButton]()
    var invokedItunesButtonGetter = false
    var invokedItunesButtonGetterCount = 0
    var stubbedItunesButton: UIButton!
    override var itunesButton: UIButton {
        set {
            invokedItunesButtonSetter = true
            invokedItunesButtonSetterCount += 1
            invokedItunesButton = newValue
            invokedItunesButtonList.append(newValue)
        }
        get {
            invokedItunesButtonGetter = true
            invokedItunesButtonGetterCount += 1
            return stubbedItunesButton
        }
    }
    var invokedConfigure = false
    var invokedConfigureCount = 0
    var invokedConfigureParameters: (album: Album?, Void)?
    var invokedConfigureParametersList = [(album: Album?, Void)]()
    override func configure(with album: Album?) {
        invokedConfigure = true
        invokedConfigureCount += 1
        invokedConfigureParameters = (album, ())
        invokedConfigureParametersList.append((album, ()))
    }
}
