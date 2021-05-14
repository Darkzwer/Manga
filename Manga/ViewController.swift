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
    
    //var HeroInfo = [track]()
    let networkService = NetworkService()//Ссылка на свифт файл
    var searchResponse: SearchResponse? = nil//Ссылка на свифт файл раньше было var и серч респонс был перемещен из моделей в нетворкинг
    private var timer: Timer?//Объявление таймера
    
    let searchController = UISearchController(searchResultsController: nil)//создание search controller

    @IBOutlet weak var collectionView: UICollectionView!////аутлет collection view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self//вызов collectionView()
        //setupTableView()//вызов TableView()
        //setupSearchBar()//вызов SearchBar()
        
        let urlString = "https://api.jikan.moe/v3/manga/1/characters"//my api link
        //let urlString = "https://api.jikan.moe/v3/top/manga/3"//my api link
        //let urlString = "https://itunes.apple.com/search?term=jack+johnson&limit=25"//api link by apple to search data need to add \(searchText) without jack+johnson
        timer?.invalidate()//1:15:27
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer) in self.networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
//            self?.searchResponse = searchResponse//or down string its about printing data
                searchResponse?.characters.map({(track) in//MangaResponce?.top.map({ (title) in
                    self?.collectionView.reloadData()
                    self?.searchResponse = searchResponse//its very impotans string
                    print("Hero name is \(track.name)")//print(manga.name)//вывод имени в консоль
                    print("Image URL is \(track.image_url)")//вывод изображений в консоль
                    print("Role is \(track.role)")//вывод роли в консоль
                    print("Mal ID is \(track.mal_id)")//ид изображений в консоль
                })
            }
        })
}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.characters.count ?? 0//count of results may be its correct
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        //let track = SearchResponse.init(characters: [track])
        cell.nameLabel.text = searchResponse?.characters[indexPath.row].name.capitalized
        let imageLink = searchResponse?.characters[indexPath.row].image_url.capitalized
        cell.imageView.downloaded(from: imageLink!)
        cell.imageView.clipsToBounds = true//imageView из аутлета текста в CustomCollectionViewCell
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height / 2
        cell.imageView.contentMode = .scaleAspectFill
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

extension UIImageView {//extension for downloading images
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    performSegue(withIdentifier: "showDetails", sender: self)//"showDetails" its identetifaer from 2->3 Screen on storybord
//}
//
//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//передача данных между контроллерами по идее
//    if let destination = segue.destination as? CustomCollectionViewCell {
//        destination.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
//    }
//}
