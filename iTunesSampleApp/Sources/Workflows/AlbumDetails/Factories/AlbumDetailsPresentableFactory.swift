//
//  AlbumDetailsPresentableFactory.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol AlbumDetailsPresentableFactory: class {
    func makeAlbumDetailsPresentable() -> AlbumDetailsPresentable
    func makeAlbumDetailsViewModel(album: Album) -> AlbumDetailsViewModel
}

class AlbumDetailsPresentableFactoryImplementation: AlbumDetailsPresentableFactory {

    // MARK: - Public

    /// create the requested presentable
    /// - Returns: an AlbumDetailsPresentable
    func makeAlbumDetailsPresentable() -> AlbumDetailsPresentable {
        return AlbumDetailsViewController()
    }

    /// create the requested viewModel
    /// - Parameter album: an Album object to pass to the viewModel
    /// - Returns: an instance of AlbumDetailsViewModel
    func makeAlbumDetailsViewModel(album: Album) -> AlbumDetailsViewModel {
        return AlbumDetailsViewModelImplementation(album: album)
    }
}
