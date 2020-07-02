//
//  NetworkPath.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

enum NetworkPath: CustomStringConvertible {
    case getMessages(_ user: String?)
    case postMessage

    var description: String {
        switch self {
        case .getMessages(let user):
            return "/messages/\(user ?? "")"
        case .postMessage:
            return "/messages"
        }
    }
}
