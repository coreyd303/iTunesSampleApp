//
//  GetMessagesResponse.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/14/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct GetMessagesResponse: Codable, Equatable {
    let messages: [Message]

    init(messages: [Message]) {
        self.messages = messages
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let responseStr = try container.decode(String.self, forKey: .body)
        let data = responseStr.data(using: .utf8)!

        messages = try JSONDecoder().decode(MessageCollection.self, from: data).messages
    }
}

extension GetMessagesResponse {
    enum CodingKeys: String, CodingKey {
        case body
    }
}

extension GetMessagesResponse {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let data = try JSONEncoder().encode(messages)
        try container.encode(data, forKey: .body)
    }
}

fileprivate struct MessageCollection: Codable, Equatable {
    let messages: [Message]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NameKey.self)

        messages = try container.allKeys.flatMap { (key) -> [Message] in
            let details = try container.decode([MessageDetails].self, forKey: NameKey(stringValue: key.stringValue).self)
            return details.map({ Message(userName: key.stringValue, details: $0) })
        }
    }
}

fileprivate struct NameKey: CodingKey {
    var intValue: Int?
    var stringValue: String

    init?(intValue: Int) {
        self.stringValue = String(intValue)
    }

    init(stringValue: String) {
        self.stringValue = stringValue
    }
}
