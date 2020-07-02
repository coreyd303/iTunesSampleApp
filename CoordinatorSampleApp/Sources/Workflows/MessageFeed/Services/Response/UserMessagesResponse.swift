//
//  UserMessageResponse.swift
//  CoordinatorSampleApp
//
//  Created by Corey Davis on 6/17/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct UserMessagesResponse: Codable, Equatable {
    var messages: [Message] = []

    init(messages: [Message]) {
        self.messages = messages
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseStr = try container.decode(String.self, forKey: .body)
        let data = responseStr.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(UserMessages.self, from: data)

        decoded.messages.forEach { (details) in
            messages.append(Message(userName: decoded.user, details: details))
        }
    }
}

extension UserMessagesResponse {
    enum CodingKeys: String, CodingKey {
        case body
    }
}

extension UserMessagesResponse {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let data = try JSONEncoder().encode(messages)
        try container.encode(data, forKey: .body)
    }
}

fileprivate struct UserMessages: Decodable, Equatable {
    let user: String
    let messages: [MessageDetails]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        user = try container.decode(String.self, forKey: .user)
        messages = try container.decode([MessageDetails].self, forKey: .message)
    }

    enum CodingKeys: String, CodingKey {
        case user, message
    }
}
