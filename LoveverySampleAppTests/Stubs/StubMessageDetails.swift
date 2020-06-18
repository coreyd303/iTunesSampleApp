//
//  StubMessageDetails.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

extension MessageDetails {
    static func stub(subject: String? = "",
                     message: String? = "") -> MessageDetails {

        return MessageDetails(subject: subject, message: message)
    }
}
