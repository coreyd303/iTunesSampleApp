//
//  LSAError.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import os.log

enum LSAError: Error {
    case customError(description: String)
}

extension LSAError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .customError(let description):
            return description
        }
    }
}

private struct Log {
    static var general: OSLog = {
        let bundleID = Bundle.main.bundleIdentifier ?? "com.diningwithrobots.CoordinatorSampleApp"
        return OSLog(subsystem: bundleID, category: "general")
    }()

    static func commit(_ message: String, log: OSLog, type: OSLogType) {
        os_log("%{public}@", log: log, type: type, message)
    }
}

/// Log an error message with os_log
/// - Parameters:
///   - fullname: the name of the function to log
///   - file: the name of the file to log
///   - line: the line to log
///   - andReport: a bool indicating if the log should also be reported to our bug reporter
///   - items: items to include in the report
func makeLog(fullname: String = #function, file: String = #file, line: Int = #line, _ items: Any?...) {
    let fileName = (file as NSString).lastPathComponent
    let content = (items.map {
        if let item = $0 as? Error {
            return item.localizedDescription
        } else if let item = $0 {
            return String(describing: item)
        } else {
            return "nil"
        }
    }).joined(separator: " ")

    let logMsg = "file: \(fileName), func: \(fullname), line: \(line), content: \(content)"
    Log.commit(logMsg, log: Log.general, type: .info)
}

/// Create a custom error from the provided description
/// - Parameter description: a string to apply to the error
func createError(_ description: String) -> LSAError {
    return LSAError.customError(description: description)
}

/// Create a custom error from the provided response code
/// - Parameter errorCode: a server response code
func createError(_ errorCode: Int) -> LSAError {
    switch errorCode {
    case 400:
        return createError("invalidRequest")
    case 404:
        return createError("notFound")
    case 500:
        return createError("serverError")
    default:
        return createError("unknownError")
    }
}
