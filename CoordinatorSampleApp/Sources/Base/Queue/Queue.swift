//
//  Queue.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

class Queue {

    /// wrapper around async dispatch, with optional qos
    /// - Parameters:
    ///   - qos: quality of service to provide during async completion
    ///   - work: work to be done
    func async(qos: DispatchQoS.QoSClass = .background, _ work: @escaping (() -> Void)) {
        DispatchQueue.global(qos: qos).async {
            work()
        }
    }

    /// wrapper around main dispatch
    /// - Parameter work: work to be done
    func main(_ work: @escaping (() -> Void)) {
        DispatchQueue.main.async {
            work()
        }
    }
}
