//
//  Pull to Refresh.swift
//  Manga
//
//  Created by Igor on 13.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit
import Foundation

//class PullToRefresh: UICollectionView {
//    @objc func refresh(sender: UIRefreshControl) {//refresh controll i need to closue func in this
//    //pageNumber+=1
//    self.collectionView.reloadData()
//    sender.endRefreshing()
//    print(pageNumber)
//    let urlString = "https://api.jikan.moe/v3/top/manga/\(pageNumber)"//my api link
//    networkService.request(urlString: urlString) { [weak self] (searchResponse, error) in
//        self?.searchResponse = searchResponse//its very impotans string отвечает за хранение данных
//        searchResponse?.top.map({(anyData) in//иерархия доступа к данным
//            //self?.searchResponse = searchResponse
//            self?.collectionView.reloadData()
//            //var AnyData = anyData
//            print("Hero name is \(anyData.title)")//print(manga.name)//вывод в консоль
//            print("Image URL is \(anyData.image_url)")//вывод в консоль
//            print("Start Date is \(anyData.start_date)")//вывод в консоль
//            print("Score is \(anyData.score)")//вывод в консоль
//            print("Count of members is \(anyData.members)")
//            print("Manga rank is \(anyData.rank)")
//            print(searchResponse?.top.count ?? 0)
//            })//searchResponse?.top.map({
//        }//networkService.request(urlString: urlString) {
//    }
//}
