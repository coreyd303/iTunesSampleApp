//
//  PostMessageResponse.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation

struct PostMessageResponse: Codable, Equatable {

    var message: Message

    init(message: Message) {
        self.message = message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let responseStr = try container.decode(String.self, forKey: .body)
        let data = responseStr.data(using: .utf8)!

        let posted = try JSONDecoder().decode(PostedMessage.self, from: data)

        message = Message(userName: posted.user, details: MessageDetails(subject: posted.subject, message: posted.message))
    }
}

extension PostMessageResponse {
    enum CodingKeys: String, CodingKey {
        case body
    }
}

extension PostMessageResponse {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let data = try JSONEncoder().encode(message)
        try container.encode(data, forKey: .body)
    }
}

fileprivate struct PostedMessage: Codable, Equatable {
    let user: String
    let subject: String
    let message: String
}
