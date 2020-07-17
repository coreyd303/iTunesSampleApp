//
//  AlbumDetailsViewModel.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol AlbumDetailsViewModel: class {
    var album: Album? { get }
    var itunesURL: String? { get }
}

class AlbumDetailsViewModelImplementation: AlbumDetailsViewModel {

    // MARK: - Properties

    private(set) var album: Album?

    var itunesURL: String? {
        return album?.url
    }

    // MARK: - Initialization

    init(album: Album) {
        self.album = album
    }
}
