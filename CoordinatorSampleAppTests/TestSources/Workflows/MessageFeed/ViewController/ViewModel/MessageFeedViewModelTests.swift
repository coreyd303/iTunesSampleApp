//
//  MessageFeedViewModelTests.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/18/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import CoordinatorSampleApp

class MessageFeedViewModelTests: QuickSpec {
    override func spec() {
        // I am only testing a couple of methods here as I feel it is important to demonstrate how API calls can be tested at this level as well as data services

        // The rest of this class would be tested fully using similar techniques to the other unit tests that are provided

        // I chose to limit the number of tests here in the interest of time

        var sut: MessageFeedViewModelImplementation!
        var mockMsgService: MockMessageService!
        var mockUsrService: MockUserService!

        beforeEach {
            mockMsgService = MockMessageService()
            mockUsrService = MockUserService()

            sut = MessageFeedViewModelImplementation(service: mockMsgService, userService: mockUsrService)
        }

        describe("signIn") {
            var stubUser: User!

            beforeEach {
                stubUser = User.stub(name: "Tom")
                try? sut.signIn(stubUser)
            }

            it("should invoke set on the userService") {
                expect(mockUsrService.invokedSetCount).to(equal(1))
            }

            it("should invoke with a matching User") {
                expect(mockUsrService.invokedSetParameters?.user).to(equal(stubUser))
            }
        }

        describe("getAllMessages") {
            it("should invoke getAllMessages on the message service") {
                sut.getAllMessages { _ in }
                expect(mockMsgService.invokedGetAllMessagesCount).to(equal(1))
            }

            describe("when getAllMessagesCompletes") {
                var invokedCompletionCount: Int!
                var invokedCompletionParams: (error: Error?, Void)?

                context("when the result is .success") {
                    var stubResponse: GetMessagesResponse!
                    var stubMessages: [Message]!

                    beforeEach {
                        stubMessages = [Message.stub(userName: "Jerry")]
                        stubResponse = GetMessagesResponse.stub(messages: stubMessages)

                        mockMsgService.stubbedGetAllMessagesCompletionResult = (Result.success(stubResponse), ())

                        sut = MessageFeedViewModelImplementation(service: mockMsgService, userService: mockUsrService)

                        invokedCompletionCount = 0
                        invokedCompletionParams = nil
                        sut.getAllMessages { (error) in
                            invokedCompletionCount += 1
                            invokedCompletionParams = (error, ())
                        }
                    }

                    it("should update the messages on sut") {
                        expect(sut.messages).to(equal(stubMessages))
                    }

                    it("should set users on sut") {
                        expect(sut.users).to(equal(["Jerry"]))
                    }

                    it("should invoke completion") {
                        expect(invokedCompletionCount).to(equal(1))
                    }

                    it("should invoke compeltion without an error") {
                        expect(invokedCompletionParams?.error).to(beNil())
                    }
                }

                context("when the result is .failure") {
                    beforeEach {
                        mockMsgService.stubbedGetAllMessagesCompletionResult = (Result.failure(MockError.stubError), ())

                        sut = MessageFeedViewModelImplementation(service: mockMsgService, userService: mockUsrService)

                        invokedCompletionCount = 0
                        invokedCompletionParams = nil
                        sut.getAllMessages { (error) in
                            invokedCompletionCount += 1
                            invokedCompletionParams = (error, ())
                        }
                    }

                    it("should invoke completion") {
                        expect(invokedCompletionCount).to(equal(1))
                    }

                    it("should invoke completion with matching error") {
                        expect(invokedCompletionParams?.error?.localizedDescription).to(equal(MockError.stubError.localizedDescription))
                    }
                }
            }
        }
    }
}
