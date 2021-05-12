//
//  ViewController.swift
//  Manga
//
//  Created by Igor on 08.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit
import Foundation
//import Alamofire

class ViewController: UIViewController, UICollectionViewDataSource {
    
    let networkService = NetworkService()
    var searchResponse: SearchResponse? = nil
    private var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var collectionView: UICollectionView!//collection view outlet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupTableView()//вызов TableView()
        //setupSearchBar()//вызов SearchBar()
        
        //let urlString = "https://api.jikan.moe/v3/top/manga/"//my api link
        
        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=25"//api link by apple to search data need to add \(searchText) without jack+johnson
        timer?.invalidate()//1:15:27
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: { (_) in self.networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
//            self?.searchResponse = searchResponse//or down string its about printing data
                searchResponse?.results.map({(track) in//MangaResponce?.top.map({ (title) in
                    self?.collectionView.reloadData()
                    print(track.trackName)//print(manga.title)//вывод изображений
                    print(track.artworkUrl60)//вывод изображений
                    print(track.artistName)
                    print(track.collectionName)
                })
            }
        })
        
}
    

/*
    private func setupSearchBar() {//visualsetupSearchBar()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {//i need to change it to CollectionView later
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIndetifier: "cell")
    }
*/

//extension func ViewController: UIViewController, UICollectionViewDataSource {//та самая функция с двумя методами которая создается через fix
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0//count of results
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        let track = searchResponse?.results[indexPath.row]//1:15:27
        //print("track?.artworkUrl60:", track?.artworkUrl60)//вывод изображений при запросе
        //print("track?.collectionName:", track?.collectionName)//вывод названий при запросе
        //cell.textLabel?.text = track?.trackName
        return cell
        }
    }
//}

extension ViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=25"//api link by apple
//        networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
//            //            self?.searchResponse = searchResponse//or down string its about printing data
//            searchResponse?.results.map({(track) in//MangaResponce?.top.map({ (title) in
//                self?.collectionView.reloadData()
//                print(track.trackName)//print(title.title)
//            })
//        }
//    }
}
