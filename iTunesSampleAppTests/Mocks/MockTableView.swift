//
//  MockTableView.swift
//  iTunesSampleAppTests
//
//  Created by Corey Davis on 6/18/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

@testable import iTunesSampleApp

class MockTableView: UITableView {
    func resetMock() {
        invokedReloadDataCount = 0
        invokedScrollToRowCount = 0
        invokedNumberOfRowsCount = 0
        invokedCellForRowCount = 0
    }

    var invokedReloadDataCount = 0
    override func reloadData() {
        invokedReloadDataCount += 1
    }

    var invokedScrollToRowCount = 0
    var invokeScrollToRowParameters: (indexPath: IndexPath, scrollPosition: UITableView.ScrollPosition, animated: Bool)?
    override func scrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        invokedScrollToRowCount += 1
        invokeScrollToRowParameters = (indexPath, scrollPosition, animated)
    }

    var stubbedNumberOfRows = 0
    var invokedNumberOfRowsCount = 0
    var invokedNumberOfRowsParameters: (section: Int, Void)?
    override func numberOfRows(inSection section: Int) -> Int {
        invokedNumberOfRowsCount += 0
        invokedNumberOfRowsParameters = (section, ())
        return stubbedNumberOfRows
    }

    var stubbedNumberOfSections = 0
    override var numberOfSections: Int {
        return stubbedNumberOfSections
    }

    var stubbedIndexPathsForVisibleRows: [IndexPath]?
    override var indexPathsForVisibleRows: [IndexPath]? {
        return stubbedIndexPathsForVisibleRows
    }

    var invokedCellForRowCount = 0
    var stubbedCell: UITableViewCell?
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        invokedScrollToRowCount += 1
        return stubbedCell
    }

    var invokedReloadRowsCount = 0
    var invokedReloadRowsParameters: (indexPaths: [IndexPath], ())?
    override func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        invokedReloadRowsCount += 1
        invokedReloadRowsParameters = (indexPaths, ())
    }
}
