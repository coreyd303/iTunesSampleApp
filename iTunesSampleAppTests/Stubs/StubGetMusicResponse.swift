//
//  StubGetMusicResponse.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

extension GetMusicResponse {
    static func stub(results: [Album] = [Album.stub()]) -> GetMusicResponse {
        return GetMusicResponse(results: results)
    }
}
