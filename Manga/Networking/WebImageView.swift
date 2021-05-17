//
//  WebImageView.swift
//  Manga
//
//  Created by Igor on 17.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        if let cachedResponce = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponce.data)
            print("from cache")
            return
        }
        
        print("from internet")
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else {return}
        let cachedResponce = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponce, for: URLRequest(url: responseURL))
    }
}
