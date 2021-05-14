//
//  SearchBar.swift
//  Manga
//
//  Created by Igor on 13.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

//import UIKit
//import Foundation
//
//class SearchBar {
//    
////    @IBOutlet weak var table: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView()//вызов TableView()
//        setupSearchBar()//вызов SearchBar()
//    }
//}
//    
//    private func setupSearchBar() {//visualsetupSearchBar()
//        navigationItem.searchController = searchController
//        searchController.searchBar.delegate = self
//        navigationController?.navigationBar.prefersLargeTitles = true
//        searchController.obscuresBackgroundDuringPresentation = false
//    }
//    
//    private func setupTableView() {//i need to change it to CollectionView later
//        table.delegate = self
//        table.dataSource = self
//        table.register(UITableViewCell.self, forCellReuseIndetifier: "cell")
//        return cell
//    }
//}
//
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10//возвращает количество строк
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "123"
//        return cell
//    }
//    
//}
