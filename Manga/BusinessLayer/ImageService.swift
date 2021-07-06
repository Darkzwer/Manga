//
//  ImageService.swift
//  Manga
//
//  Created by Igor on 26/05/2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

class ImageService {
    static let shared = ImageService()
    let cache = URLCache.shared
    func downloadImage(urlString: String, completion: @escaping (Result<UIImage, ApiError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.noImage))
            return
        }
        if let cachedResponce = cache.cachedResponse(for: URLRequest(url: url)) {
            if let image = UIImage(data: cachedResponce.data) {
                completion(.success(image))
        } else {
                completion(.failure(ApiError.noData))
            }
            print("from cache")
            return
        }
        print("from internet")

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, _) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    if let image = UIImage(data: data) {
                        self?.handleLoadedImage(data: data, response: response)
                        completion(.success(image))
                    } else {
                        completion(.failure(ApiError.noImage))
                    }
                }
            }
        }
        dataTask.resume()
    }
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
