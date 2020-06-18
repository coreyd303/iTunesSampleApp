//
//  MessageFeedPresentableFactory.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol MessageFeedPresentableFactory: class {
    func makeMessageFeedViewModel() -> MessageFeedViewModel
    func makeMessageFeedPresentable() -> MessageFeedPresentable
    func makeSignInAlertPresentable() -> UIAlertController
    func makeAddMessageAlertPresentable() -> UIAlertController
}

class MessageFeedPresentableFactoryImplementation: MessageFeedPresentableFactory {

    // MARK: - Properties

    private let userService: UserService

    // MARK: - Initialization

    init(userService: UserService) {
        self.userService = userService
    }

    // MARK: - Public

    func makeMessageFeedViewModel() -> MessageFeedViewModel {
        let dispatcher = NetworkDispatcherImplementation()
        let requestFactory = MessageServiceRequestFactoryImplementation()
        let messageService = MessageServiceImplementation(dispatcher: dispatcher, requestFactory: requestFactory)

        return MessageFeedViewModelImplementation(service: messageService, userService: userService)
    }

    /// create an instance of MessageFeedPresentable
    /// - Returns: a MessageFeedViewController as! MessageFeedPresentable
    func makeMessageFeedPresentable() -> MessageFeedPresentable {
        return MessageFeedViewController()
    }

    /// create an alert to allow "sign in"
    /// - Returns: UIAlertController as Presentable
    func makeSignInAlertPresentable() -> UIAlertController {
        let alert = UIAlertController(title: "Sign In", message: "The name you provide will be used for your posts", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "What is your name?"
        }

        return alert
    }

    /// create an alert to allow posting a new message
    /// - Returns: UIAlertController as Presentable
    func makeAddMessageAlertPresentable() -> UIAlertController {
        let name = userService.currentUser()?.name.capitalized ?? ""
        let title = "Post a message \(name)"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Subject"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "Message"
        }

        return alert
    }
}

