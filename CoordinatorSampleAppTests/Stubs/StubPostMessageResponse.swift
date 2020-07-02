//
//  StubPostMessageResponse.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/18/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import CoordinatorSampleApp

extension PostMessageResponse {
    static func stub(message: Message = Message.stub()) -> PostMessageResponse {

        return PostMessageResponse(message: message)
    }
}
