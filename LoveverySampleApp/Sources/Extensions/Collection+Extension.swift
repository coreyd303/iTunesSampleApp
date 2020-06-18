//
//  Collection+Extension.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
