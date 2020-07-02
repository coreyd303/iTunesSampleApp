//
//  MockMessageServiceRequestFactory.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import CoordinatorSampleApp

class MockMessageServiceRequestFactory: MessageServiceRequestFactory {
    var invokedMakeGetMessagesRequest = false
    var invokedMakeGetMessagesRequestCount = 0
    var stubbedMakeGetMessagesRequestResult: Request<GetMessagesResponse>!
    func makeGetMessagesRequest() -> Request<GetMessagesResponse> {
        invokedMakeGetMessagesRequest = true
        invokedMakeGetMessagesRequestCount += 1
        return stubbedMakeGetMessagesRequestResult
    }
    var invokedMakeGetUserMessagesRequest = false
    var invokedMakeGetUserMessagesRequestCount = 0
    var invokedMakeGetUserMessagesRequestParameters: (userName: String, Void)?
    var invokedMakeGetUserMessagesRequestParametersList = [(userName: String, Void)]()
    var stubbedMakeGetUserMessagesRequestResult: Request<UserMessagesResponse>!
    func makeGetUserMessagesRequest(userName: String) -> Request<UserMessagesResponse> {
        invokedMakeGetUserMessagesRequest = true
        invokedMakeGetUserMessagesRequestCount += 1
        invokedMakeGetUserMessagesRequestParameters = (userName, ())
        invokedMakeGetUserMessagesRequestParametersList.append((userName, ()))
        return stubbedMakeGetUserMessagesRequestResult
    }
    var invokedMakePostMesageRequest = false
    var invokedMakePostMesageRequestCount = 0
    var invokedMakePostMesageRequestParameters: (body: PostMessageRequestBody, Void)?
    var invokedMakePostMesageRequestParametersList = [(body: PostMessageRequestBody, Void)]()
    var stubbedMakePostMesageRequestResult: Request<PostMessageResponse>!
    func makePostMesageRequest(body: PostMessageRequestBody) -> Request<PostMessageResponse> {
        invokedMakePostMesageRequest = true
        invokedMakePostMesageRequestCount += 1
        invokedMakePostMesageRequestParameters = (body, ())
        invokedMakePostMesageRequestParametersList.append((body, ()))
        return stubbedMakePostMesageRequestResult
    }
}
