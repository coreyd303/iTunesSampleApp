//
//  MessageServiceRequestFactoryTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/18/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import LoveverySampleApp

class MessageServiceRequestFactoryTests: QuickSpec {

    override func spec() {
        var sut: MessageServiceRequestFactoryImplementation!

        beforeEach {
            sut = MessageServiceRequestFactoryImplementation(queue: MockQueue())
        }

        describe("a MessageServiceRequestFactoryImplementation") {
            it("should be a type of MessageServiceRequestFactory") {
                expect(sut).to(beAKindOf(MessageServiceRequestFactory.self))
            }

            it("should be an instance of MessageServiceRequestFactoryImplementation") {
                expect(sut).to(beAnInstanceOf(MessageServiceRequestFactoryImplementation.self))
            }

            describe("makeGetMessagesRequest") {
                var request: Request<GetMessagesResponse>!

                beforeEach {
                    request = sut.makeGetMessagesRequest()
                }

                it("should return an instance of Request<GetMessagesResponse>") {
                    expect(request).to(beAnInstanceOf(Request<GetMessagesResponse>.self))
                }

                it("should have a matching path") {
                    let expectedPath = NetworkTarget.baseURL + NetworkPath.getMessages(.none).description
                    expect(request.data.path).to(equal(expectedPath))
                }

                it("should have a matching queue") {
                    expect(request.queue).to(beAnInstanceOf(MockQueue.self))
                }
            }

            describe("makeGetUserMessagesRequest") {
                var request: Request<UserMessagesResponse>!

                beforeEach {
                    request = sut.makeGetUserMessagesRequest(userName: "Bob")
                }

                it("should return an instance of Request<UserMessagesResponse>") {
                    expect(request).to(beAnInstanceOf(Request<UserMessagesResponse>.self))
                }

                it("should have a matching path") {
                    let expectedPath = NetworkTarget.baseURL + NetworkPath.getMessages("Bob").description
                    expect(request.data.path).to(equal(expectedPath))
                }

                it("should have a matching queue") {
                    expect(request.queue).to(beAnInstanceOf(MockQueue.self))
                }
            }

            describe("makePostMesageRequest") {
                var request: Request<PostMessageResponse>!
                var stubBody: PostMessageRequestBody!

                beforeEach {
                    stubBody = PostMessageRequestBody.stub()
                    request = sut.makePostMesageRequest(body: stubBody)
                }

                it("should return an instance of Request<PostMessageResponse>") {
                    expect(request).to(beAnInstanceOf(Request<PostMessageResponse>.self))
                }

                it("should have a matching path") {
                    let expectedPath = NetworkTarget.baseURL + NetworkPath.postMessage.description
                    expect(request.data.path).to(equal(expectedPath))
                }

                it("should have a matching body") {
                    let body = try? JSONDecoder().decode(PostMessageRequestBody.self, from: request.data.body!)
                    expect(body).to(equal(stubBody))
                }

                it("should have a matching queue") {
                    expect(request.queue).to(beAnInstanceOf(MockQueue.self))
                }
            }
        }
    }
}
