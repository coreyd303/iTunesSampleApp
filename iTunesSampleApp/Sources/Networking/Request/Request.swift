//
//  Request.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct Request<T>: RequestType where T: Decodable {
    typealias ResponseType = T

    var data: RequestData
    var queue: Queue
}
