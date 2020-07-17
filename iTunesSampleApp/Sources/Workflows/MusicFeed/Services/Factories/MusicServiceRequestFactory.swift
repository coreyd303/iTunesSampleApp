//
//  MusicServiceRequestFactory.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol MusicServiceRequestFactory: class {
    func makeGetTopAlbumsRequest() -> Request<GetMusicResponse>
}

class MusicServiceRequestFactoryImplementation: MusicServiceRequestFactory {

    // MARK: - Properites

    private let queue: Queue

    // MARK: - Initialization

    init(queue: Queue = Queue()) {
        self.queue = queue
    }

    // MARK: - Public

    /// generate a GET request for top albums
    /// - Returns: returns a request object with an expected return type of GetMusicResponse
    func makeGetTopAlbumsRequest() -> Request<GetMusicResponse> {
        let requestData = RequestData(path: .getMusic(feedType: "top-albums", genre: "all", limit: 100, allowExplicit: true))

        return Request<GetMusicResponse>(data: requestData, queue: queue)
    }
}
