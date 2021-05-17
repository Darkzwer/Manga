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
    var mangas = [Manga]()//var for jsonData
    
    //var pullToRefresh = PullToRefresh()
    
    let networkService = NetworkService()//Инициализация функции NetworkService через присваивание необходимо для разделения кода по классам
    let extendedScreenViewController = ExtendedScreenViewController()//Инициализация ExtendedScreenViewController через присваивание
    
    //let refreshController = Refresh() = Pull to refresh
    
    var searchResponse: SearchResponse? = nil//Ссылка на свифт файл раньше было var и серч респонс был перемещен из моделей в нетворкинг выполняет функцию посредника
    //let searchController = UISearchController(searchResultsController: nil)//создание search controller
    
    let myRefreshControl: UIRefreshControl = {//refresh control creating
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    var pageNumber = 2//создание variable for pagination

    @IBOutlet weak var collectionView: UICollectionView!////аутлет collection view
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.refreshControl = myRefreshControl //подгрузка refreshControl()
        collectionView.dataSource = self//вызов collectionView()
        collectionView.delegate = self
        
        //setupSearchBar()//вызов SearchBar()
        //setupTableView()//вызов TableView()
        
        let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"//my api link
        
        networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
            self?.searchResponse = searchResponse//its very impotans string отвечает за хранение данных
            self?.mangas = searchResponse!.top//
            searchResponse?.top.map({(anyData) in//иерархия доступа к данным
            //self?.searchResponse = searchResponse
            //var data = SearchResponse.self
            self?.collectionView.reloadData()
                print(self?.mangas.count)
                print("Title name is \(anyData.title)")//print(manga.name)//вывод в консоль
                })//searchResponse?.top.map({
            }//networkService.request(urlString: urlString) {
        }//override func viewDidLoad() {
    
     /*
     // MARK: - CollectionView Data
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.top.count ?? 0//count of results - correct
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.nameLabel.text = mangas[indexPath.row].title.capitalized
        //cell.nameLabel.text = searchResponse?.top[indexPath.row].title.capitalized
        
        let imageLink = mangas[indexPath.row].image_url
        //let imageLink = searchResponse?.top[indexPath.row].image_url
        
        cell.imageView.downloaded(from: imageLink)
        //cell.imageView.downloaded(from: imageLink!)
        
        cell.imageView.clipsToBounds = true//imageView из аутлета текста в CustomCollectionViewCell
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height / 2
        cell.imageView.contentMode = .scaleAspectFill
        
        //cell.imageView.set = searchResponse?.top[indexPath.row].image_url
        
        return cell
    }
    
     /*
     // MARK: - Pull to Refresh
     */
    
    @objc func refresh(sender: UIRefreshControl) {//refresh controll i need to closue func in this
        //pageNumber+=1//for pagination
        self.collectionView.reloadData()
        sender.endRefreshing()
        print(pageNumber)
        let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"//my api link
        networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
            self?.searchResponse = searchResponse//its very impotans string отвечает за хранение данных
            searchResponse?.top.map({(anyData) in//иерархия доступа к данным
                //self?.handleLoadedImage(data: data, response: response)//for cached
                self?.collectionView.reloadData()
                print("Hero name is \(anyData.title)")//print(manga.name)//вывод в консоль
                print("Image URL is \(anyData.image_url)")//вывод в консоль
                print("Start Date is \(anyData.start_date)")//вывод в консоль
                print("Score is \(anyData.score)")//вывод в консоль
                print("Count of members is \(anyData.members)")
                print("Manga rank is \(anyData.rank)")
            })//searchResponse?.top.map({
        }//networkService.request(urlString: urlString) {
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
