//
//  RequestTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import LoveverySampleApp

class RequestTests: QuickSpec {
    override func spec() {
        var sut: Request<GetMessagesResponse>!

        beforeEach {
            sut = Request<GetMessagesResponse>.stubGetMessages()
        }

        describe("a Request") {
            it("should be an instance of Request") {
                expect(sut).to(beAnInstanceOf(Request<GetMessagesResponse>.self))
            }
        }

        describe("execute") {
            var mockDispatcher: MockNetworkDispatcher!
            var stubData: Data!
            var stubResponse: GetMessagesResponse!
            var invokedCompletionCount: Int!
            var invokedCompletionParameters: (result: Result<GetMessagesResponse>, ())?

            context("when result is .success") {
                beforeEach {
                    let encoder = JSONEncoder()
                    stubResponse = GetMessagesResponse.stub()
                    stubData = try? encoder.encode(stubResponse)

                    mockDispatcher = MockNetworkDispatcher()
                    mockDispatcher.stubbedDispatchCompletionResult = (Result.success(stubData), ())

                    invokedCompletionCount = 0

                    sut.execute(dispatcher: mockDispatcher) { (result) in
                        invokedCompletionCount += 1
                        invokedCompletionParameters = (result, ())
                    }
                }

                it("should invoke completion") {
                    expect(invokedCompletionCount).to(equal(1))
                }

                it("should complete with matching result") {
                    if case .success(let result)? = invokedCompletionParameters?.result {
                        expect(result).to(equal(stubResponse))
                    }
                }

                context("when the data fails to decode") {
                    beforeEach {
                        stubData = Data(base64Encoded: "Nope")

                        mockDispatcher = MockNetworkDispatcher()
                        mockDispatcher.stubbedDispatchCompletionResult = (Result.success(stubData), ())

                        invokedCompletionCount = 0

                        sut.execute(dispatcher: mockDispatcher) { (result) in
                            invokedCompletionCount += 1
                            invokedCompletionParameters = (result, ())
                        }
                    }

                    it("should invoke completion") {
                        expect(invokedCompletionCount).to(equal(1))
                    }

                    it("should invoke completion with error") {
                        if case .failure(let error)? = invokedCompletionParameters?.result {
                            expect(error?.localizedDescription).to(equal("The data couldn’t be read because it isn’t in the correct format."))
                        }
                    }
                }
            }

            context("when result is .failure") {
                beforeEach {
                    mockDispatcher = MockNetworkDispatcher()
                    mockDispatcher.stubbedDispatchCompletionResult = (Result.failure(MockError.stubError), ())

                    invokedCompletionCount = 0

                    sut.execute(dispatcher: mockDispatcher) { (result) in
                        invokedCompletionCount += 1
                        invokedCompletionParameters = (result, ())
                    }
                }

                it("should invoke completion") {
                    expect(invokedCompletionCount).to(equal(1))
                }

                it("should complete with matching error") {
                    if case .failure(let error)? = invokedCompletionParameters?.result {
                        expect(error?.localizedDescription).to(equal(MockError.stubError.localizedDescription))
                    }
                }
            }
        }
    }
}
