//
//  NewsData.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import Foundation

// MARK: NewsData
struct NewsData: Codable {
    let posts: [Post]
}
// MARK: PostData
struct PostData: Codable {
    let post: Post
}
// MARK: Post
struct Post: Codable {
    let postID, timeshamp: Int
    let title: String
    let previewText, text: String?
    let likesCount: Int
    let postImage: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
