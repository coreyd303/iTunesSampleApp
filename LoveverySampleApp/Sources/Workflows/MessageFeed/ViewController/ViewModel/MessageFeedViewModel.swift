//
//  MessageFeedViewModel.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol MessageDelegate: class {
    func didUpdateMessages(_ error: Error?, filter: String?)
}

protocol MessageFeedViewModel: class {
    var messages: [Message?] { get }
    var users: [String?] { get }
    var filterName: String? { get set }
    var delegate: MessageDelegate? { get set }

    func currentUser() -> User?
    func signIn(_ user: User) throws
    func getAllMessages(_ completion: @escaping (Error?) -> ())
    func getMessages(for userName: String?, _ completion: @escaping (Error?) -> ())
    func postMessage(msgBody: PostMessageRequestBody)
}

class MessageFeedViewModelImplementation: NSObject, MessageFeedViewModel {

    // MARK: - Properties

    var filterName: String? {
        didSet {
            getMessages(for: filterName) { [weak self] (error) in
                self?.delegate?.didUpdateMessages(error, filter: self?.filterName)
            }
        }
    }

    weak var delegate: MessageDelegate?

    private(set) var users: [String?] = []
    private(set) var messages: [Message?] = []
    private let service: MessageService
    private let userService: UserService

    // MARK: - Initialization

    init(service: MessageService, userService: UserService) {
        self.service = service
        self.userService = userService
    }

    // MARK: - Public

    /// as for current user
    /// - Returns: a User if found
    func currentUser() -> User? {
        return userService.currentUser()
    }

    /// attempt to set user in the userService
    /// - Parameter user: User object to set
    /// - Throws: if set in unsuccessful
    func signIn(_ user: User) throws {
        try userService.set(user: user)
    }

    /// request all messages
    /// - Parameter completion: callback when donw
    func getAllMessages(_ completion: @escaping (Error?) -> ()) {
        service.getAllMessages() { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.messages = response.messages
                self?.setUserNames()
                completion(.none)
            case .failure(let error):
                makeLog(error)
                completion(error)
            }
        }
    }

    /// request messages for a user
    /// - Parameters:
    ///   - userName: userName for the request
    ///   - completion: call back when done
    func getMessages(for userName: String?, _ completion: @escaping (Error?) -> ()) {
        guard let userName = userName else {
            completion(createError("Please select a user"))
            return
        }

        service.getMessages(for: userName) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.messages = response.messages
                completion(.none)
            case .failure(let error):
                makeLog(error)
                completion(error)
            }
        }
    }

    /// post a new message
    /// - Parameter msgBody: message details to send in the request
    func postMessage(msgBody: PostMessageRequestBody) {
        service.postMessage(body: msgBody) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.messages.append(response.message)
                self?.setUserNames()
                self?.delegate?.didUpdateMessages(.none, filter: .none)
            case .failure(let error):
                makeLog(error)
                self?.delegate?.didUpdateMessages(error, filter: .none)
            }
        }
    }

    // MARK: - Private

    /// update users collection based on messages
    /// - Returns: a collection of unique user names
    private func setUserNames() {
        var names: Set<String?> = []
        users = messages.map { $0?.userName }.filter { names.insert($0).inserted }
    }
}
