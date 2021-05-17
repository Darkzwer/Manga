//
//  NetworkService.swift
//  Manga
//
//  Created by Igor on 11.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (SearchResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }//or use ! on url! parametr
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error { //or if let error = error
                    print("Parse Error")
                    completion(nil, error)
                    return
                }
                guard let data = data else {return}
                //let someString = String(data: data, encoding: .utf8)//проверка получения данных
                //print(someString ?? "no data")//вывод данных в консоль
                do {
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: data)//декодирование полученных данных 56:15
                    completion(tracks, nil)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(nil, jsonError)
                }
            }
        }.resume()//или запрос не будет обработан
    }
}
