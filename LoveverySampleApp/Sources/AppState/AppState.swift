//
//  AppState.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

enum AppState {
    case launching
    case main
}

extension AppState: Equatable {
    public static func == (lhs: AppState, rhs: AppState) -> Bool {
        switch(lhs, rhs) {
        case(.launching, .launching):
            return true
        case(.main, .main):
            return true
        case(.launching, _), (.main, _):
            return false
        }
    }
}
