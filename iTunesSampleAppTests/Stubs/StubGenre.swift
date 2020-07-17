//
//  StubGenre.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 7/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

@testable import iTunesSampleApp

extension Genre {
    static func stub(genreId: String = "",
                     name: String = "",
                     url: String = "") -> Genre {

        return Genre(genreId: genreId, name: name, url: url)
    }
}
