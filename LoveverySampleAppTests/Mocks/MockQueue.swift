//
//  MockQueue.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockQueue: Queue {
    override func async(qos: DispatchQoS.QoSClass = .background, _ work: @escaping (() -> Void)) {
        work()
    }

    override func main(_ work: @escaping (() -> Void)) {
        work()
    }
}
