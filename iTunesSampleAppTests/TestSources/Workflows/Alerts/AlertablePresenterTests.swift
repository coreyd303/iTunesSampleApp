//
//  AlertablePresenterTests.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import iTunesSampleApp

class AlertablePresenterTests: QuickSpec {

    override func spec() {
        var sut: MockPresentable!

        beforeEach {
            sut = MockPresentable()

            sut.presentAlert(error: MockError.stubError)
        }

        it("should invoke present") {
            expect(sut.invokedPresentCount).to(equal(1))
        }

        it("should invoke present with matching error") {
            let alert = sut.invokedPresentParameters?.presentable as? UIAlertController

            expect(alert?.message).to(equal(MockError.stubError.localizedDescription))
        }
    }
}
