//
//  RequestData.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct RequestData {

    // MARK: - Properties

    let path: String
    let method: HTTPMethod
    let body: Data?

    // MARK: - Initialization

    init(path: NetworkPath, method: HTTPMethod = .get, body: Data? = nil) {
        self.path = NetworkTarget.baseURL + path.description
        self.method = method
        self.body = body
    }
}
