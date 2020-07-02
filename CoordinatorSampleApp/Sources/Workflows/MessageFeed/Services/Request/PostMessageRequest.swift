//
//  PostMessageRequest.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct PostMessageRequestBody: Codable, Equatable {
    let user: String
    let operation: String = "add_message"
    let subject: String
    let message: String
}
