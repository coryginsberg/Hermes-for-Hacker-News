//
//  Copyright (c) 2022 Cory Ginsberg.
//
//  Licensed under the Apache License, Version 2.0
//

import Foundation

typealias Stories = [Int]


// MARK: - Story
struct Story: Codable {
    let by: String
    let descendants: Int
    let id: Int
    let kids: [Int]
    let score: Int
    let time: Int
    let title: String
    let type: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case by
        case descendants
        case id
        case kids
        case score
        case time
        case title
        case type
        case url
    }
}

// MARK: - Comment
struct Comment: Codable {
    let by: String
    let id: Int
    let kids: [Int]
    let parent: Int
    let text: String
    let time: Int
    let type: String
}

// MARK: - AskHN
struct AskHN: Codable {
    let by: String
    let descendants, id: Int
    let kids: [Int]
    let score: Int
    let text: String
    let time: Int
    let title, type: String
}

// MARK: - JobListing
struct JobListing: Codable {
    let by: String
    let id, score: Int
    let text: String
    let time: Int
    let title, type, url: String
}

// MARK: - Poll
struct Poll: Codable {
    let by: String
    let descendants, id: Int
    let kids, parts: [Int]
    let score: Int
    let text: String
    let time: Int
    let title, type: String
}

// MARK: - PollItem
struct PollItem: Codable {
    let by: String
    let id, poll, score: Int
    let text: String
    let time: Int
    let type: String
}

// MARK: - User
struct User: Codable {
    let about: String
    let created, delay: Int
    let id: String
    let karma: Int
    let submitted: [Int]
}

// MARK: - ChangedItems
struct ChangedItems: Codable {
    let items: [Int]
    let profiles: [String]
}

