//
//  MockError.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

enum MockError: LocalizedError {
    case stubError

    var errorDescription: String? {
        return "OOPS"
    }
}
