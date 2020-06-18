//
//  StubGetMessagesResponse.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

extension GetMessagesResponse {
    static func stub(messages: [Message] = [Message.stub()]) -> GetMessagesResponse {

        return GetMessagesResponse(messages: messages)
    }
}
