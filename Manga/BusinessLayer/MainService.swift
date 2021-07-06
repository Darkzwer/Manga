//
//  MainService.swift
//  Manga
//
//  Created by Igor on 02/06/2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import Foundation

class MainService {
    static let shared = MainService()
    let reachability = ReichabilityService.shared
    let api = ApiService.shared
    let storage = StorageManger.shared
    func getManga (page: Int, completion: @escaping (Result<[Manga], ApiError>) -> Void) {
        let isConnected = reachability.isNetworkConnect()
        if isConnected {
            api.requestManga(page: page) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let manga):
                    self.storage.saveData(manga)
                }
                completion(result)
            }
        } else {
            if let data = self.storage.getData(), !data.isEmpty {
                completion(.success(data))
            } else {
                completion(.failure(ApiError.noData))
            }
        }
    }
}
