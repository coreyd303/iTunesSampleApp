//
//  StartupCoordinator.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol StartupCoordinator: Coordinator {
    var didFinish: (() -> ())? { get set }
}

class StarupCoordinatorImplementation: StartupCoordinator {

    // MARK: - Properties

    var didFinish: (() -> ())?

    private let musicService: MusicService
    private let imageCache: ImageCache

    // MARK: - Initialization

    init(musicService: MusicService, imageCache: ImageCache) {
        self.musicService = musicService
        self.imageCache = imageCache
    }

    // MARK: - Coordinator

    func start() {
        musicService.getMusic { [weak self] (result) in
            switch result {
            case .success(let response):
                response.results.forEach { (album) in
                    guard let url = URL(string: album.artworkUrl100) else { return }
                    self?.imageCache.loadImage(with: url, nil)
                }

                self?.didFinish?()
            case .failure(let error):
                makeLog(error)
                self?.didFinish?()
            }
        }
    }
}
