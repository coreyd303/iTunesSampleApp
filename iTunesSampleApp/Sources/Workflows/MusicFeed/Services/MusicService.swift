//
//  MusicService.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol MusicService: class {
    func getMusic(_ completion: @escaping (Result<GetMusicResponse>) -> Void)
}

class MusicServiceImplementation: MusicService {

    // MARK: - Properties

    private let dispatcher: NetworkDispatcher
    private let requestFactory: MusicServiceRequestFactory

    // MARK: - Initalization

    init(dispatcher: NetworkDispatcher, requestFactory: MusicServiceRequestFactory) {
        self.dispatcher = dispatcher
        self.requestFactory = requestFactory
    }

    // MARK: - Public

    /// request all messages
    /// - Parameters:
    ///   - completion: callback when done with result
    func getMusic(_ completion: @escaping (Result<GetMusicResponse>) -> Void) {
        let request = requestFactory.makeGetTopAlbumsRequest()
        request.execute(dispatcher: dispatcher) { (result) in
            completion(result)
        }
    }
}
