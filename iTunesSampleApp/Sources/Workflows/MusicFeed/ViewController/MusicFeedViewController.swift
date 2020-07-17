//
//  MusicFeedViewController.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol MusicFeedPresentable: Presentable {
    var didFinish: (() -> ())? { get set }
    var didTapAlbum: ((Album?) -> ())? { get set }
    var viewModel: MusicFeedViewModel? { get set }
}

class MusicFeedViewController: UIViewController, MusicFeedPresentable, AlertablePresenter {

    // MARK: - Properties

    var didFinish: (() -> ())?
    var didTapAlbum: ((Album?) -> ())?
    var viewModel: MusicFeedViewModel?

    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(MusicFeedCell.self, forCellReuseIdentifier: MusicFeedCell.identifier)

        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        applyDesign()
        setup()

        if viewModel?.albums.isEmpty == true {
            requestData()
        }
    }


    // MARK: - Private

    private func setup() {
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        title = "Music Feed"
    }

    /// request albums
    private func requestData() {
        viewModel?.getTopAlbums { [weak self] (error) in
            if let error = error {
                self?.presentAlert(error: error)
            } else {
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }
    }
}

extension MusicFeedViewController {

    // MARK: - Design

    private func applyDesign() {
        view.backgroundColor = .white

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MusicFeedViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.albums.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = MusicFeedCell.identifier

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MusicFeedCell else {
            return UITableViewCell()
        }

        if let album = viewModel?.albums[safe: indexPath.item] {
            cell.configure(with: album)
        }

        return cell
    }
}

extension MusicFeedViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let album = viewModel?.albums[safe: indexPath.row] else {
            presentAlert(error: createError("That ablum is unavailable"))
            return
        }

        didTapAlbum?(album)
    }
}
