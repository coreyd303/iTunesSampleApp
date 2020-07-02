//
//  MessageServiceTests.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import CoordinatorSampleApp

class MessageServiceTests: QuickSpec {

    override func spec() {
        var sut: MessageServiceImplementation!
        var mockDispatcher: MockNetworkDispatcher!
        var mockFactory: MockMessageServiceRequestFactory!
        var stubData: Data!

        beforeEach {
            mockDispatcher = MockNetworkDispatcher()
            mockFactory = MockMessageServiceRequestFactory()
            sut = MessageServiceImplementation(dispatcher: mockDispatcher, requestFactory: mockFactory)
        }

        describe("a MessageServiceImplementation") {
            it("should be a type of MessageService") {
                expect(sut).to(beAKindOf(MessageService.self))
            }

            it("should be an intance of MessageServiceImplementation") {
                expect(sut).to(beAnInstanceOf(MessageServiceImplementation.self))
            }

            describe("getAllMessages") {
                var stubGetMessagesRequest: Request<GetMessagesResponse>!
                var stubGetMessagesResponse: GetMessagesResponse!

                var invokedCompletionCount: Int!
                var invokedCompletionParams: (result: Result<GetMessagesResponse>, Void)?

                beforeEach {
                    stubGetMessagesResponse = GetMessagesResponse.stub()
                    stubData = try? JSONEncoder().encode(stubGetMessagesResponse)


                    mockDispatcher.stubbedDispatchCompletionResult = (.success(stubData), ())

                    stubGetMessagesRequest = Request<GetMessagesResponse>.stubGetMessages()
                    mockFactory.stubbedMakeGetMessagesRequestResult = stubGetMessagesRequest
                    sut = MessageServiceImplementation(dispatcher: mockDispatcher, requestFactory: mockFactory)

                    invokedCompletionCount = 0
                    invokedCompletionParams = nil
                    sut.getAllMessages { (result) in
                        invokedCompletionCount += 1
                        invokedCompletionParams = (result, ())
                    }
                }

                it("should invoke makeGetMessagesRequest on the factory") {
                    expect(mockFactory.invokedMakeGetMessagesRequestCount).to(equal(1))
                }

                describe("when request executes completes") {
                    it("should invoke a completion") {
                        expect(invokedCompletionCount).to(equal(1))
                    }

                    it("should invoke a completion with a matching result") {
                        if case .success(let result)? = invokedCompletionParams?.result{
                            expect(result).to(equal(stubGetMessagesResponse))
                        }
                    }
                }
            }

            describe("getMessages for userName") {
                var stubUserMessagesRequest: Request<UserMessagesResponse>!
                var stubUserMessagesResponse: UserMessagesResponse!

                var invokedCompletionCount: Int!
                var invokedCompletionParams: (result: Result<UserMessagesResponse>, Void)?

                beforeEach {
                    stubUserMessagesResponse = UserMessagesResponse.stub()
                    stubData = try? JSONEncoder().encode(stubUserMessagesResponse)

                    mockDispatcher.stubbedDispatchCompletionResult = (.success(stubData), ())

                    stubUserMessagesRequest = Request<UserMessagesResponse>.stubGetUserMessages()
                    mockFactory.stubbedMakeGetUserMessagesRequestResult = stubUserMessagesRequest
                    sut = MessageServiceImplementation(dispatcher: mockDispatcher, requestFactory: mockFactory)

                    invokedCompletionCount = 0
                    invokedCompletionParams = nil
                    sut.getMessages(for: "Bob") { (result) in
                        invokedCompletionCount += 1
                        invokedCompletionParams = (result, ())
                    }
                }

                it("should invoke makeGetUserMessagesRequest on the factory") {
                    expect(mockFactory.invokedMakeGetUserMessagesRequestCount).to(equal(1))
                }

                describe("when request execute completes") {
                    it("should invoke a completion") {
                        expect(invokedCompletionCount).to(equal(1))
                    }

                    it("should invoke a completion with a matching result") {
                        if case .success(let result)? = invokedCompletionParams?.result{
                            expect(result).to(equal(stubUserMessagesResponse))
                        }
                    }
                }
            }

            describe("postMessage") {
                var stubPostMessageRequest: Request<PostMessageResponse>!
                var stubPostMessageResponse: PostMessageResponse!
                var stubRequestBody: PostMessageRequestBody!

                var invokedCompletionCount: Int!
                var invokedCompletionParams: (result: Result<PostMessageResponse>, Void)?

                beforeEach {
                    stubPostMessageResponse = PostMessageResponse.stub()
                    stubData = try? JSONEncoder().encode(stubPostMessageResponse)

                    mockDispatcher.stubbedDispatchCompletionResult = (.success(stubData), ())

                    stubRequestBody = PostMessageRequestBody.stub()
                    stubPostMessageRequest = Request<PostMessageResponse>.stubPostMessage(body: stubRequestBody)
                    mockFactory.stubbedMakePostMesageRequestResult = stubPostMessageRequest
                    sut = MessageServiceImplementation(dispatcher: mockDispatcher, requestFactory: mockFactory)

                    invokedCompletionCount = 0
                    invokedCompletionParams = nil

                    sut.postMessage(body: stubRequestBody) { (result) in
                        invokedCompletionCount += 1
                        invokedCompletionParams = (result, ())
                    }
                }

                it("should invoke makePostMessageRequest on the factory") {
                    expect(mockFactory.invokedMakePostMesageRequestCount).to(equal(1))
                }

                describe("when request execute completes") {
                    it("should invoke a completion") {
                        expect(invokedCompletionCount).to(equal(1))
                    }

                    it("should invoke a completion with a matching result") {
                        if case .success(let result)? = invokedCompletionParams?.result{
                            expect(result).to(equal(stubPostMessageResponse))
                        }
                    }
                }
            }
        }
    }
}
