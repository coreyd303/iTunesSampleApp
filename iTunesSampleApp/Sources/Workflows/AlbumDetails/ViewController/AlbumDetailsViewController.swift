//
//  AlbumDetailsViewController.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol AlbumDetailsPresentable: Presentable {
    var didFinish: (() -> ())? { get set }
    var didRequestAlbum: ((String) -> ())? { get set }
    var viewModel: AlbumDetailsViewModel? { get set }
}


class AlbumDetailsViewController: UIViewController, AlbumDetailsPresentable, AlertablePresenter {

    // MARK: - Properties

    var didFinish: (() -> ())?
    var didRequestAlbum: ((String) -> ())?
    var viewModel: AlbumDetailsViewModel?

    lazy var detailView: AlbumDetailsView = {
        let view = AlbumDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        applyDesign()
        setup()
    }

    // MARK: - Private

    private func setup() {
        if let album = viewModel?.album {
            detailView.configure(with: album)
        } else {
            didFinish?()
        }

        detailView.didFinish = { [weak self] in
            self?.didFinish?()
        }

        detailView.didRequestAlbum = { [weak self] in
            if let urlString = self?.viewModel?.itunesURL {
                self?.didRequestAlbum?(urlString)
            } else {
                self?.presentAlert(error: createError("Sorry, we weren't able to open that album"))
            }
        }
    }
}

extension AlbumDetailsViewController {

    // MARK: - Design

    private func applyDesign() {
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
