//
//  UserServiceTests.swift
//  LoveverySampleAppTests
//
//  Created by Corey Davis on 6/18/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import LoveverySampleApp

class UserServiceTests: QuickSpec {
    override func spec() {
        var sut: UserServiceImplementation!
        var mockDefaults: MockUserDefaults!
        var stubUser: User!

        beforeEach {
            mockDefaults = MockUserDefaults()
            stubUser = User.stub(name: "JoJo")
            let data = try! JSONEncoder().encode(stubUser)
            mockDefaults.stubbedObjectForKey = data

            sut = UserServiceImplementation(userDefaults: mockDefaults)
        }

        describe("set user") {
            beforeEach {
                try? sut.set(user: User.stub())
            }

            it("should invoke set on userDefaults") {
                expect(mockDefaults.invokedSetValueCount).to(equal(1))
            }
        }

        describe("currentUser") {
            var user: User!

            beforeEach {
                user = sut.currentUser()
            }

            it("should invoke object forKey on userDefaults") {
                expect(mockDefaults.invokedObjectForKeyCount).to(equal(1))
            }

            it("should return a matching user") {
                expect(user).to(equal(stubUser))
            }
        }

        describe("deleteCurrentUser") {
            beforeEach {
                sut.deleteCurrentUser()
            }

            it("should invoke removeObject on userDefaults") {
                expect(mockDefaults.invokedRemoveObjectForKeyCount).to(equal(1))
            }
        }
    }
}
