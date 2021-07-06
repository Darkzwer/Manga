//
//  NetworkService.swift
//  Manga
//
//  Created by Igor on 11.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case wrongUrl, parseError, noData, jsonDecodeError, noImage
}

class ApiService {
    static let shared = ApiService()
    enum Constants {
        static let urlPostfix = "manga/"
    }
    func requestManga(page: Int, completion: @escaping (Result<[Manga], ApiError>) -> Void) {
        let urlString = AppConstans.url + Constants.urlPostfix + "\(page)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.wrongUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("No data")
                    completion(.failure(.noData))
                    return
                }
                guard let data = data else {
                    completion(.failure(.jsonDecodeError))
                    return
                }
                do {
                    let mangas = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(mangas.top))
                } catch let jsonError {
                    print("Parse Error", jsonError)
                    completion(.failure(.parseError))
                    return
                }
            }
        }.resume()
    }
}
