//
//  Message.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct Message: Codable, Equatable {
    let userName: String
    let details: MessageDetails
}

struct MessageDetails: Codable, Equatable {
    let subject: String?
    let message: String?
}
