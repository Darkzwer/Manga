//
//  StorageManger.swift
//  Manga
//
//  Created by Igor on 30/05/2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import Foundation

class StorageManger {
    enum Constants {
        static let saveKey = "savedData"
    }
    static let shared = StorageManger()
    private let defaults = UserDefaults.standard
    func getData() -> [Manga]? {
        guard let savedData = defaults.object(forKey: Constants.saveKey) as? Data else { return nil }
        guard let loadedData = try? JSONDecoder().decode([Manga].self, from: savedData) else { return nil  }
        return loadedData
    }
    func saveData(_ manga: [Manga]) {
        guard let modelEncoded = try? JSONEncoder().encode(manga) else { return }
        defaults.set(modelEncoded, forKey: Constants.saveKey)
    }
}
