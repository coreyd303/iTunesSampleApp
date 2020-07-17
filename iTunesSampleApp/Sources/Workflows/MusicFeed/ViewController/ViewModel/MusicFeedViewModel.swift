//
//  MusicFeedViewModel.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol MusicFeedViewModel: class {
    var albums: [Album?] { get }

    func getTopAlbums(_ completion: @escaping (Error?) -> ())
}

class MusicFeedViewModelImplementation: NSObject, MusicFeedViewModel {

    // MARK: - Properties

    private(set) var albums: [Album?] = []
    private let service: MusicService


    // MARK: - Initialization

    init(service: MusicService) {
        self.service = service
    }

    // MARK: - Public

    /// request Top Albums from the API service
    /// - Parameter completion: call back when done with optional error
    func getTopAlbums(_ completion: @escaping (Error?) -> ()) {
        service.getMusic { [weak self] result in
            switch result {
            case .success(let response):
                self?.albums = response.results
                completion(.none)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
