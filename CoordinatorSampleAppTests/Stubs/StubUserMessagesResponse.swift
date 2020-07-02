//
//  StubUserMessagesResponse.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/18/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import CoordinatorSampleApp

extension UserMessagesResponse {
    static func stub(messages: [Message] = []) -> UserMessagesResponse {

        return UserMessagesResponse(messages: messages)
    }
}
