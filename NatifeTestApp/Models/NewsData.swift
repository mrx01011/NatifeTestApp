//
//  NewsData.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import Foundation

// MARK: NewsInfo
struct NewsInfo: Codable {
    let posts: [Post]
}

// MARK: Post
struct Post: Codable {
    let postID, timeshamp: Int
    let title, previewText: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
