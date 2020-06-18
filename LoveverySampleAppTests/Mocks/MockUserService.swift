//
//  MockUserService.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import LoveverySampleApp

class MockUserService: UserService {
    var invokedSet = false
    var invokedSetCount = 0
    var invokedSetParameters: (user: User, Void)?
    var invokedSetParametersList = [(user: User, Void)]()
    var stubbedSetError: Error?
    func set(user: User) throws {
        invokedSet = true
        invokedSetCount += 1
        invokedSetParameters = (user, ())
        invokedSetParametersList.append((user, ()))
        if let error = stubbedSetError {
            throw error
        }
    }
    var invokedCurrentUser = false
    var invokedCurrentUserCount = 0
    var stubbedCurrentUserResult: User!
    func currentUser() -> User? {
        invokedCurrentUser = true
        invokedCurrentUserCount += 1
        return stubbedCurrentUserResult
    }
    var invokedDeleteCurrentUser = false
    var invokedDeleteCurrentUserCount = 0
    func deleteCurrentUser() {
        invokedDeleteCurrentUser = true
        invokedDeleteCurrentUserCount += 1
    }
}
