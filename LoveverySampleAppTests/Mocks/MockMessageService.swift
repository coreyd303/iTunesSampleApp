//
//  MockMessageService.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockMessageService: MessageService {
    var invokedGetAllMessages = false
    var invokedGetAllMessagesCount = 0
    var stubbedGetAllMessagesCompletionResult: (Result<GetMessagesResponse>, Void)?
    func getAllMessages(_ completion: @escaping (Result<GetMessagesResponse>) -> Void) {
        invokedGetAllMessages = true
        invokedGetAllMessagesCount += 1
        if let result = stubbedGetAllMessagesCompletionResult {
            completion(result.0)
        }
    }
    var invokedGetMessages = false
    var invokedGetMessagesCount = 0
    var invokedGetMessagesParameters: (userName: String, Void)?
    var invokedGetMessagesParametersList = [(userName: String, Void)]()
    var stubbedGetMessagesCompletionResult: (Result<UserMessagesResponse>, Void)?
    func getMessages(for userName: String, _ completion: @escaping (Result<UserMessagesResponse>) -> Void) {
        invokedGetMessages = true
        invokedGetMessagesCount += 1
        invokedGetMessagesParameters = (userName, ())
        invokedGetMessagesParametersList.append((userName, ()))
        if let result = stubbedGetMessagesCompletionResult {
            completion(result.0)
        }
    }
    var invokedPostMessage = false
    var invokedPostMessageCount = 0
    var invokedPostMessageParameters: (body: PostMessageRequestBody, Void)?
    var invokedPostMessageParametersList = [(body: PostMessageRequestBody, Void)]()
    var stubbedPostMessageCompletionResult: (Result<PostMessageResponse>, Void)?
    func postMessage(body: PostMessageRequestBody, _ completion: @escaping (Result<PostMessageResponse>) -> Void) {
        invokedPostMessage = true
        invokedPostMessageCount += 1
        invokedPostMessageParameters = (body, ())
        invokedPostMessageParametersList.append((body, ()))
        if let result = stubbedPostMessageCompletionResult {
            completion(result.0)
        }
    }
}
