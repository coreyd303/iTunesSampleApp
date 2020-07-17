//
//  Result.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

/// A better, cleaner implementation of Swift's Result<> type
enum Result<Value> {
    case success(Value)
    case failure(Error?)
}


