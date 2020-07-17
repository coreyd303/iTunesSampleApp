//
//  StubRequest.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

extension Request {
    static func stubGetTopAlbums() -> Request<GetMusicResponse> {
        let requestData = RequestData(path: .getMusic(feedType: "Any", genre: "Any", limit: 1, allowExplicit: true))

        return Request<GetMusicResponse>(data: requestData, queue: MockQueue())
    }

}
