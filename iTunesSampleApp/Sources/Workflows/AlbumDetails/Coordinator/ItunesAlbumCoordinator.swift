//
//  ItunesAlbumCoordinator.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol ItunesAlbumCoordinator: Coordinator {
    var didFinish: (() -> ())? { get set }
}

class ItunesAlbumCoordinatorImplementation: ItunesAlbumCoordinator {

    // MARK: - Properties

    var didFinish: (() -> ())?

    private let url: URL

    // MARK: - Initialization

    init(url: URL) {
        self.url = url
    }

    // MARK: - Coordinator

    func start() {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        didFinish?()
    }
}
