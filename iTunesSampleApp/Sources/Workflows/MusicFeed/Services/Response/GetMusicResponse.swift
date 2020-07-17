//
//  GetMusicResponse.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct GetMusicResponse: Codable, Equatable {

    // MARK: - Properties

    let results: [Album]

    // MARK: - Initialization

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let feedContainer = try container.nestedContainer(keyedBy: FeedKeys.self, forKey: .feed)

        results = try feedContainer.decode([Album].self, forKey: .results)
    }

    init(results: [Album]) {
        self.results = results
    }

    // MARK: - Public

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var feedContainer = container.nestedContainer(keyedBy: FeedKeys.self, forKey: .feed)
        let data = try JSONEncoder().encode(results)
        try feedContainer.encode(data, forKey: .results)
    }
}

extension GetMusicResponse {

    // MARK: - CodingKeys

    private enum CodingKeys: String, CodingKey {
        case feed
    }

    private enum FeedKeys: String, CodingKey {
        case results
    }
}
