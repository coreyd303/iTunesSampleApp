//
//  StartupCoordinator.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Fakery

protocol StartupCoordinator: Coordinator {
    var didFinish: (() -> ())? { get set }
}

class StarupCoordinatorImplementation: StartupCoordinator {

    // MARK: - Properties

    var didFinish: (() -> ())?

    private let messageService: MessageService
    private let faker: Faker

    // MARK: - Initialization

    init(messageService: MessageService, faker: Faker = Faker()) {
        self.messageService = messageService
        self.faker = faker
    }

    // MARK: - Coordinator

    func start() {
        seed { [weak self] in
            self?.didFinish?()
        }
    }

    // MARK: - Private

    /// Seed a message into the API
    /// - Parameter completion: callback when done
    private func seed(_ completion: @escaping () -> ()) {
        let name = ["sam", "tom", "sally"].randomElement()!
        let subject = faker.lorem.word()
        let message = faker.lorem.words(amount: 3)

        let body = PostMessageRequestBody(user: name, subject: subject, message: message)

        messageService.postMessage(body: body) { (result) in
            switch result {
            case .success:
                completion()
            case .failure(let error):
                makeLog(error)
                completion()
            }
        }
    }
}
