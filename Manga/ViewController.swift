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
    
    let networkService = NetworkService()//Инициализация функции NetworkService через присваивание необходимо для разделения кода по классам
    let extendedScreenViewController = ExtendedScreenViewController()//Инициализация ExtendedScreenViewController через присваивание
    
    var searchResponse: SearchResponse? = nil//Ссылка на свифт файл раньше было var и серч респонс был перемещен из моделей в нетворкинг выполняет функцию посредника
    
    let myRefreshControl: UIRefreshControl = {//refresh control creating
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    var pageNumber = 1//создание variable for pagination
    
    @IBOutlet weak var collectionView: UICollectionView!////аутлет collection view
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
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
            //self?.searchResponse?.top = searchResponse//its very impotans string отвечает за хранение данных
            //guard let mangasArray = searchResponse?.top else {return}
            self?.mangasArray = searchResponse!.top//Заполнение массива для вывода, данными
            //guard let currentMangasArray = searchResponse?.top else {return}
            self?.currentMangasArray = searchResponse!.top//Заполнение массива для фильтрации(поиска), данными
            self?.collectionView.reloadData()
            
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
        //pageNumber+=1
        return currentMangasArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        let imageLink = currentMangasArray[indexPath.row].image_url
        
        cell.nameLabel.text = currentMangasArray[indexPath.row].title.capitalized
        
        cell.imageView.downloaded(from: imageLink)
        
        cell.imageView.clipsToBounds = true
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
    }
    
    /*
     // MARK: - pagination
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
        //let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"
        //pageNumber+=1
        fetchingMore = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        pageNumber += 1//for pagination
        //pageNumber = 1//for refresh
        //self.collectionView.reloadData()
        //sender.endRefreshing()
        let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"//my api link
        networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
            self?.searchResponse = searchResponse//its very impotans string отвечает за хранение данных
            self?.collectionView.reloadData()
        }//networkService.request(urlString: urlString) {
        
        
        //self.networkService.request(urlString: urlString) { (response, error) in
        //}
        //fetchingAPI data here!!!

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let newManga = self.searchResponse!.top//передача данных для хранения or var
            self.currentMangasArray.append(contentsOf: newManga)//добавление данных в конец массива
            self.activityIndicator.stopAnimating()
            self.fetchingMore = false
            self.collectionView.reloadData()
        })
    }
    
    @objc func refresh(sender: UIRefreshControl) {//refresh controll i need to closue func in this
        pageNumber = 1//for pagination
        //pageNumber = 1//for refresh
        //self.collectionView.reloadData()
        sender.endRefreshing()
        let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"//my api link
        networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
        self?.searchResponse = searchResponse//its very impotans string отвечает за хранение данных
        self?.collectionView.reloadData()
        }//networkService.request(urlString: urlString) {
    }
}
