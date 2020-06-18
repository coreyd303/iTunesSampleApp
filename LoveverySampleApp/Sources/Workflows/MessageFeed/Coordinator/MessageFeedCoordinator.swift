//
//  MessageFeedCoordinator.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol MessageFeedCoordinator: Coordinator {
    var didFinish: (() -> ())? { get set }
}

class MessageFeedCoordinatorImplementation: BaseCoordinator, MessageFeedCoordinator {

    // MARK: - Properties

    private let router: Router
    private let presentableFactory: MessageFeedPresentableFactory
    private let childFactory: MessageFeedChildCoordinatorFactory
    private var viewModel: MessageFeedViewModel?

    var didFinish: (() -> ())?

    // MARK: - Initialization

    init(router: Router, presentableFactory: MessageFeedPresentableFactory, childFactory: MessageFeedChildCoordinatorFactory) {
        self.router = router
        self.presentableFactory = presentableFactory
        self.childFactory = childFactory
    }

    // MARK: - Coordinator

    override func start() {
        viewModel = presentableFactory.makeMessageFeedViewModel()

        let presentable = presentableFactory.makeMessageFeedPresentable()
        presentable.viewModel = viewModel
        viewModel?.delegate = presentable as? MessageDelegate
        viewModel?.getAllMessages { (_) in }

        presentable.didFinish = { [weak self] in
            self?.didFinish?()
        }

        presentable.didTapAddMessage = { [weak self] in
            if let alert = self?.presentableFactory.makeAddMessageAlertPresentable() {
                let submit = UIAlertAction(title: "Submit", style: .default) { (action) in
                    guard let subject = alert.textFields?[safe: 0]?.text?.lowercased() else { return }
                    guard let message = alert.textFields?[safe: 1]?.text?.lowercased() else { return }
                    guard let user = self?.viewModel?.currentUser()?.name.lowercased() else { return }

                    let msgBody = PostMessageRequestBody(user: user, subject: subject, message: message)
                    self?.viewModel?.postMessage(msgBody: msgBody)
                }

                let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                alert.addAction(submit)
                alert.addAction(cancel)

                presentable.present(alert, animated: true, completion: nil)
            }
        }

        presentable.didTapSignIn = { [weak self] in
            if let alert = self?.presentableFactory.makeSignInAlertPresentable() {
                let action = UIAlertAction(title: "Let's Go!", style: .default) { (action) in
                    if let name = alert.textFields?[0].text {
                        do {
                            try self?.viewModel?.signIn(User(name: name))
                        } catch {
                            presentable.present(error: error)
                        }
                    }

                    presentable.setNavigation()
                }
                alert.addAction(action)
                presentable.present(alert, animated: true, completion: nil)
            }
        }

        presentable.didTapFilterMessages = { [weak self] names in
            self?.presentPicker(with: names)
        }

        router.push(presentable)
    }

    // MARK: - Private

    /// trigger filter picker workflow
    /// - Parameter names: a collection of names that will be presented in the filter picker
    private func presentPicker(with names: [String?]) {
        let childCoordinator = childFactory.makeFilterPickerCoordinator()
        addDependency(childCoordinator)

        childCoordinator.didFinish = { [weak self] value in
            self?.viewModel?.filterName = value
            self?.router.dismissPresentable(animated: true, completion: { [weak self] in
                self?.removeDependency(childCoordinator)
            })
        }

        childCoordinator.start(with: names)
    }
}
