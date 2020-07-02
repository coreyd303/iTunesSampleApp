//
//  AlertablePresenter.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol AlertablePresenter: class {
    func presentAlert(error: Error)
}

extension AlertablePresenter where Self: Presentable {

    /// present an alert on self with provided error
    /// - Parameter error: and Error to present
    func presentAlert(error: Error) {
        let alert = UIAlertController(title: "Woops!", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)

        self.present(alert, animated: false, completion: nil)
    }
}
