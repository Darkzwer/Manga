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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //var HeroInfo = [track]()
    let networkService = NetworkService()//Инициализация функции NetworkService через присваивание
    let extendedScreenViewController = ExtendedScreenViewController()//Инициализация ExtendedScreenViewController через присваивание
    var searchResponse: SearchResponse? = nil//Ссылка на свифт файл раньше было var и серч респонс был перемещен из моделей в нетворкинг
    private var timer: Timer?//Объявление таймера
    
    let searchController = UISearchController(searchResultsController: nil)//создание search controller
    
    let refresh = UIRefreshControl()//создание refreshControl
    
    var pageNumber = 2//создание variable for pagination

    @IBOutlet weak var collectionView: UICollectionView!////аутлет collection view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self//вызов collectionView()
        collectionView.delegate = self
        collectionView.refreshControl = refresh//вызов refreshControl()
        
        //setupSearchBar()//вызов SearchBar()
        //setupTableView()//вызов TableView()
        
        //let urlString = "https://api.jikan.moe/v3/manga/1/characters"//my api link
        let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"//my api link
        //let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=25"//api link by apple to search data need to add \(searchText) without jack+johnson
        
        timer?.invalidate()//1:15:27
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (timer) in self.networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
//            self?.searchResponse = searchResponse//or down string its about printing data
                searchResponse?.top.map({(track) in//MangaResponce?.top.map({ (title) in
                    self?.searchResponse = searchResponse//its very impotans string пристваивание свойству данных???
                    self?.collectionView.reloadData()
                    print("Hero name is \(track.title)")//print(manga.name)//вывод в консоль
                    print("Image URL is \(track.image_url)")//вывод в консоль
                    print("Start Date is \(track.start_date)")//вывод в консоль
                    print("Score is \(track.score)")//вывод в консоль
                })
            }
        })
}
    
     /*
     // MARK: - CollectionView Data
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.top.count ?? 0//count of results may be correct
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.nameLabel.text = searchResponse?.top[indexPath.row].title.capitalized
        //var imageLink = searchResponse?.characters[indexPath.row].image_url.capitalized
        //cell.imageView = searchResponse?.characters[indexPath.row].image_url.capitalized
        //let track = SearchResponse.init(characters: [track])
        let imageLink = searchResponse?.top[indexPath.row].image_url
        cell.imageView.downloaded(from: imageLink!)
        cell.imageView.clipsToBounds = true//imageView из аутлета текста в CustomCollectionViewCell
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height / 2
        cell.imageView.contentMode = .scaleAspectFill
        return cell
        }
    }

//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    performSegue(withIdentifier: "showDetails", sender: self)
//}//may be correct

//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    performSegue(withIdentifier: "showDetails", sender: self)//"showDetails" its identetifaer from 2->3 Screen on storybord
//}
//
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//передача данных между контроллерами по идее
//    if let destination = segue.destination as? CustomCollectionViewCell {
//        destination.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
//    }
//}
