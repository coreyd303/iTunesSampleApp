//
//  MusicFeedPresentableFactory.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol MusicFeedPresentableFactory: class {
    func makeMusicFeedViewModel() -> MusicFeedViewModel
    func makeMusicFeedPresentable() -> MusicFeedPresentable
}

class MusicFeedPresentableFactoryImplementation: MusicFeedPresentableFactory {

    // MARK: - Public

    func makeMusicFeedViewModel() -> MusicFeedViewModel {
        let dispatcher = NetworkDispatcherImplementation()
        let requestFactory = MusicServiceRequestFactoryImplementation()
        let musicService = MusicServiceImplementation(dispatcher: dispatcher, requestFactory: requestFactory)

        return MusicFeedViewModelImplementation(service: musicService)
    }

    /// create an instance of MusicFeedPresentable
    /// - Returns: a MusicFeedViewController as! MusicFeedPresentable
    func makeMusicFeedPresentable() -> MusicFeedPresentable {
        return MusicFeedViewController()
    }
}

