//
//  NetworkManager.swift
//  NatifeTestApp
//
//  Created by MacBook on 01.09.2023.
//

import Foundation

final class NetworkManager {
    private let queue = DispatchQueue(label: "NetworkManager_queue_working", qos: .userInitiated)
    
    func getNewsList(completion: (([Post]) -> Void)?) {
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json") else { return }
        queue.async {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data,
                   let newsData = try? JSONDecoder().decode(NewsData.self, from: data) {
                    DispatchQueue.main.async {
                        completion?(newsData.posts)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getPostBy(id: Int, completion: ((PostData) -> Void)?) {
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(id).json") else { return }
        queue.async {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data,
                   let post = try? JSONDecoder().decode(PostData.self, from: data) {
                    DispatchQueue.main.async {
                        completion?(post)
                    }
                }
            }
            task.resume()
        }
    }
}
