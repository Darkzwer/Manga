//
//  ViewController.swift
//  Manga
//
//  Created by Igor on 08.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController, UICollectionViewDataSource {
    let networkService = NetworkService()//Ссылка на свифт файл
    var searchResponse: SearchResponse? = nil//Ссылка на свифт файл
    private var timer: Timer?//Объявление таймера
    
    let searchController = UISearchController(searchResultsController: nil)//создание search controller

    @IBOutlet weak var collectionView: UICollectionView!////аутлет collection view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self//вызов collectionView()
        //setupTableView()//вызов TableView()
        //setupSearchBar()//вызов SearchBar()
        
        let urlString = "https://api.jikan.moe/v3/manga/1/characters"//my api link
        
        //let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=25"//api link by apple to search data need to add \(searchText) without jack+johnson
        timer?.invalidate()//1:15:27
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in self.networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
//            self?.searchResponse = searchResponse//or down string its about printing data
                searchResponse?.characters.map({(track) in//MangaResponce?.top.map({ (title) in
                    self?.collectionView.reloadData()
                    print(track.name)//print(manga.title)//вывод изображений
                    //print(track.artworkUrl60)//вывод изображений
                    //print(track.artistName)
                    //print(track.collectionName)
                })
            }
        })
}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.characters.count ?? 0//count of results
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        let track = searchResponse?.characters[indexPath.row]//1:15:27
        //print("track?.artworkUrl60:", track?.artworkUrl60)//вывод изображений при запросе
        //print("track?.collectionName:", track?.collectionName)//вывод названий при запросе
        //cell.nameLabel?.text = track?.title//nameLabl из аутлета текста в CustomCollectionViewCell
        return cell
        }
    }

//extension ViewController: UICollectionView {//являются аналогами экстеншена из поиска только для коллекции
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 25
//}
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return cell
//    }
//}
