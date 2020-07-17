//
//  MusicFeedCoordinator.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol MusicFeedCoordinator: Coordinator {
    var didFinish: (() -> ())? { get set }
}

class MusicFeedCoordinatorImplementation: BaseCoordinator, MusicFeedCoordinator {

    // MARK: - Properties

    private let router: Router
    private let presentableFactory: MusicFeedPresentableFactory
    private let childFactory: MusicFeedChildCoordinatorFactory
    private var viewModel: MusicFeedViewModel?

    var didFinish: (() -> ())?

    // MARK: - Initialization

    init(router: Router, presentableFactory: MusicFeedPresentableFactory, childFactory: MusicFeedChildCoordinatorFactory) {
        self.router = router
        self.presentableFactory = presentableFactory
        self.childFactory = childFactory
    }

    // MARK: - Coordinator

    override func start() {
        viewModel = presentableFactory.makeMusicFeedViewModel()

        let presentable = presentableFactory.makeMusicFeedPresentable()
        presentable.viewModel = viewModel

        presentable.didTapAlbum = { [weak self] album in
            guard let album = album else { return }
            self?.presentAlbumDetails(album)
        }


        presentable.didFinish = { [weak self] in
            self?.didFinish?()
        }

        router.push(presentable)
    }

    // MARK: - Private

    private func presentAlbumDetails(_ album: Album) {
        let childCoordinator = childFactory.makeAlbumDetailCoordinator()

        addDependency(childCoordinator)
        childCoordinator.didFinish = { [weak self] in
            self?.removeDependency(childCoordinator)
        }

        childCoordinator.start(with: album)
    }
}
