//
//  MessageService.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol MessageService: class {
    func getAllMessages(_ completion: @escaping (Result<GetMessagesResponse>) -> Void)
    func getMessages(for userName: String, _ completion: @escaping (Result<UserMessagesResponse>) -> Void)
    func postMessage(body: PostMessageRequestBody, _ completion: @escaping (Result<PostMessageResponse>) -> Void)
}

class MessageServiceImplementation: MessageService {

    // MARK: - Properties

    private let dispatcher: NetworkDispatcher
    private let requestFactory: MessageServiceRequestFactory

    // MARK: - Initalization

    init(dispatcher: NetworkDispatcher, requestFactory: MessageServiceRequestFactory) {
        self.dispatcher = dispatcher
        self.requestFactory = requestFactory
    }

    // MARK: - Public

    /// request all messages
    /// - Parameters:
    ///   - completion: callback when done with result
    func getAllMessages(_ completion: @escaping (Result<GetMessagesResponse>) -> Void) {
        let request = requestFactory.makeGetMessagesRequest()
        request.execute(dispatcher: dispatcher) { (result) in
            completion(result)
        }
    }

    /// request messages for a user
    /// - Parameters:
    ///   - userName: the user name to get message for
    ///   - completion: callback when done with result
    func getMessages(for userName: String, _ completion: @escaping (Result<UserMessagesResponse>) -> Void) {
        let request = requestFactory.makeGetUserMessagesRequest(userName: userName)
        request.execute(dispatcher: dispatcher) { (result) in
            completion(result)
        }
    }

    /// post a message
    /// - Parameters:
    ///   - body: the body to encode for the request
    ///   - completion: callback when done
    func postMessage(body: PostMessageRequestBody, _ completion: @escaping (Result<PostMessageResponse>) -> Void) {
        let request = requestFactory.makePostMesageRequest(body: body)
        request.execute(dispatcher: dispatcher) { (result) in
            completion(result)
        }
    }
}
