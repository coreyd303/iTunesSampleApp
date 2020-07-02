//
//  StubRequest.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import CoordinatorSampleApp

extension Request {
    static func stubGetMessages() -> Request<GetMessagesResponse> {
        let requestData = RequestData(path: .getMessages(.none), method: .get)

        return Request<GetMessagesResponse>(data: requestData, queue: MockQueue())
    }

    static func stubGetUserMessages() -> Request<UserMessagesResponse> {
        let requestData = RequestData(path: .getMessages("Stub"), method: .get)

        return Request<UserMessagesResponse>(data: requestData, queue: MockQueue())
    }

    static func stubPostMessage(body: PostMessageRequestBody = PostMessageRequestBody.stub()) -> Request<PostMessageResponse> {
        let data = try? JSONEncoder().encode(body)
        let requestData = RequestData(path: .postMessage, method: .post, body: data)

        return Request<PostMessageResponse>(data: requestData, queue: MockQueue())
    }
}

extension PostMessageRequestBody {
    static func stub(user: String = "", subject: String = "", message: String = "") -> PostMessageRequestBody {

        return PostMessageRequestBody(user: user, subject: subject, message: message)
    }
}
