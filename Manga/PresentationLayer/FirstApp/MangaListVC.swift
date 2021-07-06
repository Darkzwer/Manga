//
//  ViewController.swift
//  Manga
//
//  Created by Igor on 08.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

class MangaListVC: UIViewController, UICollectionViewDelegate {
    enum Constants {
        static let itemsPerRow: CGFloat = 2
        static let cellIdentifier = "customCell"
        static let segueIdentifier = "detailScreenSegue"
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private var pageNumber = 1
    private let mainService = MainService()//
    private var mangas = [Manga]()//
    private var searchMangas = [Manga]()//
    private var canFetchingMore = false//
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()

    // MARK: override func
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        searchBar.delegate = self
        searchMangas = mangas
        collectionView.refreshControl = myRefreshControl
        collectionView.dataSource = self
        collectionView.delegate = self
        hideKeyboardWhenTappedAround()
        setupNavigationBar()
        dowloadData()
    }
    
    func setupAlertActions() -> [UIAlertAction] {
        let reloadAction = UIAlertAction(title: "Reload", style: .default, handler: { [weak self] _ in
            self?.dowloadData()
        })
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        return [reloadAction, actionOk]
    }
    
    func dowloadData() {
        mainService.getManga(page: pageNumber) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let mangas):
                self.searchMangas.append(contentsOf: mangas)
                self.mangas.append(contentsOf: mangas)
                self.activityIndicator.stopAnimating()
                self.canFetchingMore = false
                self.collectionView.reloadData()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlertController(title: "text",
                                        message: "text",
                                        preferredStyle: .alert,
                                        buttonAction: self.setupAlertActions())
                }
                print("error:", error)
            }
        }
    }
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueIdentifier {
            if let mangaVC = segue.destination as? DetailVC, let customCell = sender as? CustomCollectionViewCell,
                let indexPath = collectionView.indexPath(for: customCell) {
                mangaVC.manga = mangas[indexPath.row]
            }
        }
    }
    func setupNavigationBar () {
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        } else {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }

    // MARK: - Pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        if offsetY > contentHight - scrollView.frame.height {
            if !canFetchingMore {
                beginBatchFetch()
            }
        }
    }

    func beginBatchFetch() {
        canFetchingMore = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        pageNumber += 1
        dowloadData()
    }

    // MARK: Pull to refresh
    @objc func refresh(sender: UIRefreshControl) {
        pageNumber = 1
        dowloadData()
        sender.endRefreshing()
    }
}
// MARK: CollectionViewDataSource
extension MangaListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMangas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt
        indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        cell.apply(searchMangas[indexPath.row])
        return cell
    }
}
// MARK: SearchBar
extension MangaListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchMangas = mangas
            collectionView.reloadData()
            return
        }
        searchMangas = mangas.filter({ manga -> Bool in
            manga.title.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
}
