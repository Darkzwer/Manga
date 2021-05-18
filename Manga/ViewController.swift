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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    var mangasArray = [Manga]()//var for jsonData
    var currentMangasArray = [Manga]()//update collection
    var fetchingMore = false
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
    
    var pageNumber = 1//создание variable for pagination

    @IBOutlet weak var collectionView: UICollectionView!////аутлет collection view
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        setUpSearchBar()//вызов SearchBar()
        collectionView.refreshControl = myRefreshControl //подгрузка refreshControl()
        collectionView.dataSource = self//вызов collectionView()
        collectionView.delegate = self
        //setupTableView()//вызов TableView()
        
        //loadingcell
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        collectionView.register(loadingNib, forCellWithReuseIdentifier: "loadingCell")
        //url link
        let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"//my api link
        //network request
        networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
            self?.searchResponse = searchResponse//its very impotans string отвечает за хранение данных
            self?.mangasArray = searchResponse!.top//Заполнение массива для вывода, данными
            self?.currentMangasArray = searchResponse!.top//Заполнение массива для фильтрации(поиска), данными
            searchResponse?.top.map({(anyData) in//иерархия доступа к данным
            //self?.searchResponse = searchResponse
            //var data = SearchResponse.self
            self?.collectionView.reloadData()
                print(self?.mangasArray.count)
                print("Title name is \(anyData.title)")//print(manga.name)//вывод в консоль
                })//searchResponse?.top.map({
            }//networkService.request(urlString: urlString) {
        }//override func viewDidLoad() {
    
    private func setUpMangas() {
        currentMangasArray = mangasArray
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
     /*
     // MARK: - CollectionView Data
     */
    
    // Collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMangasArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        let imageLink = currentMangasArray[indexPath.row].image_url
        cell.nameLabel.text = currentMangasArray[indexPath.row].title.capitalized
        //cell.nameLabel.text = searchResponse?.top[indexPath.row].title.capitalized
        cell.imageView.downloaded(from: imageLink)
        cell.imageView.clipsToBounds = true//imageView из аутлета текста в CustomCollectionViewCell
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height / 2
        cell.imageView.contentMode = .scaleAspectFill
        return cell
    }
    
     /*
     // MARK: - SearchBar
     */
    
    //search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentMangasArray = mangasArray
            collectionView.reloadData()
            return
        }
        currentMangasArray = mangasArray.filter({ manga -> Bool in
            manga.title.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        switch selectedScope {
//        case 0:
//            currentMangasArray = mangasArray
//        case 1:
//            currentMangasArray = mangasArray.filter({ manga -> Bool in
//                manga.rank == AnimeType.manga
//            })
//        case 2:
//            currentMangasArray = mangasArray.filter({ manga -> Bool in
//                manga.score == AnimeType.anime
//            })
//        default:
//            break
//        }
//        collectionView.reloadData()
    }
    
     /*
     // MARK: - Pull to Refresh
     */
    
    //pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {//watching
        let offsetY = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        if offsetY > contentHight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        pageNumber+=1
        let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"
        fetchingMore = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        //fetchingAPI data here!!!
        networkService.request(urlString: urlString) { (response, error) in
            //self.searchResponse = self.searchResponse
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {//timer 1 second
            //let newItems = (self.items.count...self.items.count + 12).map { index in index}
            //let newManga = (self.mangasArray.count).map { index in index }
            //self.mangasArray.append(contentsOf: newManga)
            //let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"
            //networkService.request(urlString: urlString) { (response, error) in
            //self.searchResponse = self.searchResponse
            let newManga = self.searchResponse!.top//передача данных для хранения
            self.currentMangasArray.append(contentsOf: newManga)//добавление данных в конец массива
            self.activityIndicator.stopAnimating()
            self.fetchingMore = false
            self.collectionView.reloadData()
        })
    }
    
    @objc func refresh(sender: UIRefreshControl) {//refresh controll i need to closue func in this
//        pageNumber+=1//for pagination
        self.collectionView.reloadData()
        sender.endRefreshing()
//        print(pageNumber)
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
