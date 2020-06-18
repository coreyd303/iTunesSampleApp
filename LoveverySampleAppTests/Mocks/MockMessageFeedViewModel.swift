//
//  MockMessageFeedViewModel.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockMessageFeedViewModel: MessageFeedViewModel {
    var invokedMessagesGetter = false
    var invokedMessagesGetterCount = 0
    var stubbedMessages: [Message?]! = []
    var messages: [Message?] {
        invokedMessagesGetter = true
        invokedMessagesGetterCount += 1
        return stubbedMessages
    }
    var invokedUsersGetter = false
    var invokedUsersGetterCount = 0
    var stubbedUsers: [String?]! = []
    var users: [String?] {
        invokedUsersGetter = true
        invokedUsersGetterCount += 1
        return stubbedUsers
    }
    var invokedFilterActiveGetter = false
    var invokedFilterActiveGetterCount = 0
    var stubbedFilterActive: Bool! = false
    var filterActive: Bool {
        invokedFilterActiveGetter = true
        invokedFilterActiveGetterCount += 1
        return stubbedFilterActive
    }
    var invokedFilterNameSetter = false
    var invokedFilterNameSetterCount = 0
    var invokedFilterName: String?
    var invokedFilterNameList = [String?]()
    var invokedFilterNameGetter = false
    var invokedFilterNameGetterCount = 0
    var stubbedFilterName: String!
    var filterName: String? {
        set {
            invokedFilterNameSetter = true
            invokedFilterNameSetterCount += 1
            invokedFilterName = newValue
            invokedFilterNameList.append(newValue)
        }
        get {
            invokedFilterNameGetter = true
            invokedFilterNameGetterCount += 1
            return stubbedFilterName
        }
    }
    var invokedDelegateSetter = false
    var invokedDelegateSetterCount = 0
    var invokedDelegate: MessageDelegate?
    var invokedDelegateList = [MessageDelegate?]()
    var invokedDelegateGetter = false
    var invokedDelegateGetterCount = 0
    var stubbedDelegate: MessageDelegate!
    var delegate: MessageDelegate? {
        set {
            invokedDelegateSetter = true
            invokedDelegateSetterCount += 1
            invokedDelegate = newValue
            invokedDelegateList.append(newValue)
        }
        get {
            invokedDelegateGetter = true
            invokedDelegateGetterCount += 1
            return stubbedDelegate
        }
    }
    var invokedCurrentUser = false
    var invokedCurrentUserCount = 0
    var stubbedCurrentUserResult: User!
    func currentUser() -> User? {
        invokedCurrentUser = true
        invokedCurrentUserCount += 1
        return stubbedCurrentUserResult
    }
    var invokedSignIn = false
    var invokedSignInCount = 0
    var invokedSignInParameters: (user: User, Void)?
    var invokedSignInParametersList = [(user: User, Void)]()
    var stubbedSignInError: Error?
    func signIn(_ user: User) throws {
        invokedSignIn = true
        invokedSignInCount += 1
        invokedSignInParameters = (user, ())
        invokedSignInParametersList.append((user, ()))
        if let error = stubbedSignInError {
            throw error
        }
    }
    var invokedGetAllMessages = false
    var invokedGetAllMessagesCount = 0
    var stubbedGetAllMessagesCompletionResult: (Error?, Void)?
    func getAllMessages(_ completion: @escaping (Error?) -> ()) {
        invokedGetAllMessages = true
        invokedGetAllMessagesCount += 1
        if let result = stubbedGetAllMessagesCompletionResult {
            completion(result.0)
        }
    }
    var invokedGetMessages = false
    var invokedGetMessagesCount = 0
    var invokedGetMessagesParameters: (userName: String?, Void)?
    var invokedGetMessagesParametersList = [(userName: String?, Void)]()
    var stubbedGetMessagesCompletionResult: (Error?, Void)?
    func getMessages(for userName: String?, _ completion: @escaping (Error?) -> ()) {
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
    var invokedPostMessageParameters: (msgBody: PostMessageRequestBody, Void)?
    var invokedPostMessageParametersList = [(msgBody: PostMessageRequestBody, Void)]()
    func postMessage(msgBody: PostMessageRequestBody) {
        invokedPostMessage = true
        invokedPostMessageCount += 1
        invokedPostMessageParameters = (msgBody, ())
        invokedPostMessageParametersList.append((msgBody, ()))
    }
}
