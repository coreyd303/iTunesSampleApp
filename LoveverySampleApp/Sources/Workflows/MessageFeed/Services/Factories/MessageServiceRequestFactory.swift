//
//  MessageServiceRequestFactory.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol MessageServiceRequestFactory: class {
    func makeGetMessagesRequest() -> Request<GetMessagesResponse>
    func makeGetUserMessagesRequest(userName: String) -> Request<UserMessagesResponse>
    func makePostMesageRequest(body: PostMessageRequestBody) -> Request<PostMessageResponse>
}

class MessageServiceRequestFactoryImplementation: MessageServiceRequestFactory {

    // MARK: - Properites

    private let queue: Queue

    // MARK: - Initialization

    init(queue: Queue = Queue()) {
        self.queue = queue
    }

    // MARK: - Public

    /// generate a GET messages request
    /// - Parameter user: optional user name value for the request
    /// - Returns: returns a request object with an expected return type of MessageResponse
    func makeGetMessagesRequest() -> Request<GetMessagesResponse> {
        let requestData = RequestData(path: .getMessages(.none))

        return Request<GetMessagesResponse>(data: requestData, queue: queue)
    }

    /// generate a GET messages for user request
    /// - Parameter userName: the userName to get messages for
    /// - Returns: a request object with an expected return type of UserMessageResponse
    func makeGetUserMessagesRequest(userName: String) -> Request<UserMessagesResponse> {
        let requestData = RequestData(path: .getMessages(userName))

        return Request<UserMessagesResponse>(data: requestData, queue: queue)
    }

    /// generate a POST message request
    /// - Parameters:
    ///   - user: non-optional user name value for the request
    ///   - body: request body for the message to post
    /// - Returns: a request object with an expected return type of UserMessageResponse
    func makePostMesageRequest(body: PostMessageRequestBody) -> Request<PostMessageResponse> {
        let data = try? JSONEncoder().encode(body)
        let requestData = RequestData(path: .postMessage, method: .post, body: data)

        return Request<PostMessageResponse>(data: requestData, queue: queue)
    }
}
