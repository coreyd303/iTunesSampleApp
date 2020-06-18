//
//  MessageFeedViewController.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol MessageFeedPresentable: Presentable {
    var didFinish: (() -> ())? { get set }
    var didTapAddMessage: (() -> ())? { get set }
    var didTapSignIn: (() -> ())? { get set }
    var didTapFilterMessages: (([String?]) -> ())? { get set }
    var viewModel: MessageFeedViewModel? { get set }

    func setNavigation()
    func present(error: Error)
}

class MessageFeedViewController: UIViewController, MessageFeedPresentable, AlertablePresenter {

    // MARK: - Properties

    var didFinish: (() -> ())?
    var didTapAddMessage: (() -> ())?
    var didTapSignIn: (() -> ())?
    var didTapFilterMessages: (([String?]) -> ())?
    var viewModel: MessageFeedViewModel?

    private(set) lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .systemBlue
        control.addTarget(self, action: #selector(didRequestRefresh), for: .valueChanged)

        return control
    }()

    lazy var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(MessageFeedCell.self, forCellReuseIdentifier: MessageFeedCell.identifier)

        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        applyDesign()
        setup()
        setNavigation()
        setNavigationTitle(.none)
        if viewModel?.messages.isEmpty == true {
            requestData()
        }
    }

    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
    }

    // MARK: - Public

    func setNavigation() {
        if viewModel?.currentUser() != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMessageTapped))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterMessagesTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In", style: .plain, target: self, action: #selector(signInTapped))
            navigationItem.leftBarButtonItem = nil
        }
    }

    func present(error: Error) {
        presentAlert(error: error)
    }



    // MARK: - Private

    /// request messages
    private func requestData() {
        viewModel?.getAllMessages { [weak self] (error) in
            if self?.refreshControl.isRefreshing == true {
                self?.refreshControl.endRefreshing()
            }

            self?.setNavigationTitle(.none)

            if let error = error {
                self?.presentAlert(error: error)
            } else {
                self?.tableView.reloadData()
            }
        }
    }

    /// update the navigationBar title
    /// - Parameter filterName: a name to use in the title
    private func setNavigationTitle(_ filterName: String?) {
        self.title = filterName == nil ? "Lovevery Sample App" : "Viewing \(filterName?.capitalized ?? "User")'s Posts"
    }

}

extension MessageFeedViewController {

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

extension MessageFeedViewController {

    // MARK: - Actions

    @objc private func addMessageTapped() {
        didTapAddMessage?()
    }

    @objc private func signInTapped() {
        didTapSignIn?()
    }

    @objc private func filterMessagesTapped() {
        if let names = viewModel?.users {
            didTapFilterMessages?(names)
        }
    }

    @objc private func didRequestRefresh() {
        requestData()
    }
}

extension MessageFeedViewController: MessageDelegate {

    // MARK: - MessageDelegate

    /// delegate call back when messages are updated
    /// - Parameter error: optional error to present
    func didUpdateMessages(_ error: Error?, filter: String?) {
        if let error = error {
            self.presentAlert(error: error)
        } else {
            setNavigationTitle(filter)
            tableView.reloadData()
        }
    }
}

extension MessageFeedViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.messages.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = MessageFeedCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MessageFeedCell else {
            return UITableViewCell()
        }

        if let message = viewModel?.messages[safe: indexPath.item] {
            cell.configure(with: message)
        }

        return cell
    }
}

extension MessageFeedViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
