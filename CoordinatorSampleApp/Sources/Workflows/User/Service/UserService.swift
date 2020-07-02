//
//  UserService.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol UserService: class {
    func set(user: User) throws
    func currentUser() -> User?
    func deleteCurrentUser()
}

class UserServiceImplementation: UserService {

    // MARK: - Properties

    private let userDefaults: UserDefaults

    // MARK: - Initialization

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    // MARK: - Public

    /// set a User object in userDefaults
    /// - Parameter user: User object representing the current user
    /// - Throws: an error if encoding fails
    func set(user: User) throws {
        let encoded = try JSONEncoder().encode(user)
        userDefaults.set(encoded, forKey: "currentUser")
    }

    /// get the currentuser from defaults if present
    /// - Throws: an error if no user can be found or decoded
    /// - Returns: a User object representing the current user
    func currentUser() -> User? {
        guard let saved = userDefaults.object(forKey: "currentUser") as? Data else {
            return nil
        }

        return try? JSONDecoder().decode(User.self, from: saved)
    }

    /// remove any object under currentUser key from defaults
    func deleteCurrentUser() {
        userDefaults.removeObject(forKey: "currentUser")
    }
}
