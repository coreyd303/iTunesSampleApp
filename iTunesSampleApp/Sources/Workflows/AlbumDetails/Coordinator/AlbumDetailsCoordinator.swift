//
//  AlbumDetailsCoordinator.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol AlbumDetailsCoordinator: Coordinator {
    func start(with album: Album)
    var didFinish: (() -> ())? { get set }
}

class AlbumDetailsCoordinatorImplementation: BaseCoordinator, AlbumDetailsCoordinator {

    // MARK: - Properties

    private let router: Router
    private let presentableFactory: AlbumDetailsPresentableFactory
    private let childCoordinatorFactory: AlbumDetailsChildCoordinatorFactory
    private var presentable: AlbumDetailsPresentable?

    var didFinish: (() -> ())?

    // MARK: - Initialization

    init(router: Router, presentableFactory: AlbumDetailsPresentableFactory, childCoordinatorFactory: AlbumDetailsChildCoordinatorFactory) {
        self.router = router
        self.presentableFactory = presentableFactory
        self.childCoordinatorFactory = childCoordinatorFactory
    }

    // MARK: - Coordinator

    /// custom start with album parameter
    /// - Parameter album: an Album object to provide to the view model
    func start(with album: Album) {
        presentable = presentableFactory.makeAlbumDetailsPresentable()
        presentable?.didFinish = { [weak self] in
            self?.router.pop()
            self?.didFinish?()
        }

        presentable?.didRequestAlbum = { [weak self] url in
            self?.presentAlbum(url)
        }

        let viewModel = presentableFactory.makeAlbumDetailsViewModel(album: album)
        presentable?.viewModel = viewModel

        start()
    }

    internal override func start() {
        if let presentable = presentable {
            router.push(presentable)
        }
    }

    // MARK: - Private

    /// present album in itunes via coordinator
    /// - Parameter url: the url of the album to present
    private func presentAlbum(_ url: String) {
        guard let url = URL(string: url) else {
            return
        }

        let childCoordinator = childCoordinatorFactory.makeItunesCoordinator(url: url)
        addDependency(childCoordinator)

        childCoordinator.didFinish = { [weak self] in
            self?.removeDependency(childCoordinator)
        }

        childCoordinator.start()
    }
}
