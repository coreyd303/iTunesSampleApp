//
//  FilterPickerCoordinator.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

protocol FilterPickerCoordinator: Coordinator {
    var didFinish: ((String?) -> ())? { get set }
    func start(with names: [String?])
}

class FilterPickerCoordinatorImplementation: FilterPickerCoordinator {

    // MARK: - Properties

    private let router: Router
    private let presentableFactory: FilterPickerPresentableFactory
    private var presentable: FilterPickerPresentable?

    var didFinish: ((String?) -> ())?

    // MARK: - Initialization

    init(router: Router, presentableFactory: FilterPickerPresentableFactory) {
        self.router = router
        self.presentableFactory = presentableFactory
    }

    // MARK: - Public

    /// start coordinator with a collection of names
    /// - Parameter names: a collection of names based on the current messages in the app
    func start(with names: [String?]) {
        presentable = presentableFactory.makeFilterPickerPresentable()
        presentable?.names = names

        presentable?.didFinish = { [weak self] in
            self?.didFinish?(.none)
        }

        presentable?.didSelectFilter = { [weak self] value in
            self?.didFinish?(value)
        }

        start()
    }

    // MARK: - Coordinator

    internal func start() {
        if let presentable = presentable {
            router.present(presentable, animated: true, completion: nil)
        }
    }
}
