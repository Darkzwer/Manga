//
//  NewViewController.swift
//  Manga
//
//  Created by Igor on 11.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import Foundation
import UIKit
import Foundation
//import Alamofire

//struct Hero: Codable {//indian struct
//    let localized_name: String//name
//    let img: String//image
//}
/*
class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!//collection view outlet
    
    let searchController = UISearchController(searchResultsController: nil)//my searchController

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "123"
        return cell
    }
    
}
let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=25"//api link
guard let url = URL(string: urlString) else { return }//or use ! on url! parametr
URLSession.shared.dataTask(with: url) { (data, response, error) in
    DispatchQueue.main.async {
        if let error = error { //or if let error = error
            print("Parse Error")
            return
        }
        guard let data = data else {return}
        let someString = String(data: data, encoding: .utf8)
        print(someString ?? "no data")
    }
    }.resume()//или запрос не будет обработан

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

*/
