//
//  MockNetworkDispatcher.swift
//  CoordinatorSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import CoordinatorSampleApp

class MockNetworkDispatcher: NetworkDispatcher {
    var invokedDispatch = false
    var invokedDispatchCount = 0
    var invokedDispatchParameters: (request: RequestData, Void)?
    var invokedDispatchParametersList = [(request: RequestData, Void)]()
    var stubbedDispatchCompletionResult: (Result<Data>, Void)?
    func dispatch(request: RequestData, completion: @escaping ((Result<Data>) -> Void)) {
        invokedDispatch = true
        invokedDispatchCount += 1
        invokedDispatchParameters = (request, ())
        invokedDispatchParametersList.append((request, ()))
        if let result = stubbedDispatchCompletionResult {
            completion(result.0)
        }
    }
}
