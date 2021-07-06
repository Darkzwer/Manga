//
//  DetailVC.swift
//  Manga
//
//  Created by Igor on 14.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var startLabel: UILabel!
    @IBOutlet private weak var endLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var volumesLabel: UILabel!
    @IBOutlet private weak var membersLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var urlTextView: UITextView!
    var favorites = [Manga]()
    var manga: Manga?
    private var imageService = ImageService()
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setLabel()
        backgroundSetup()
    }
    func setImage() {
        if let urlString = manga?.imageUrl {
            imageService.downloadImage(urlString: urlString) { [weak self] (result) in
                switch result {
                case .success(let image):
                    self?.imageView.image = image
                case .failure(let error):
                    print("error:", error)
                }
            }
        }
    }
    func setLabel() {
        guard let mangas = manga else { return }
        titleLabel.text = mangas.title.capitalized
        urlTextView.text = mangas.url
        urlTextView.isEditable = false
        urlTextView.isScrollEnabled = false
        startLabel.text = "From: \(mangas.startDate.capitalized ) 📅"
        endLabel.text = "Until: \(mangas.endDate?.capitalized ?? "Current Time") 📅"
        membersLabel.text = "Members: \(mangas.members ) 👩🏼‍💻"
        rankLabel.text = "Rank: \(mangas.rank ) 🔢"
        scoreLabel.text = "Score: \(mangas.score ) ⭐️"
        if manga?.type == "Light" {
            typeLabel.text = "Type: \(mangas.type.capitalized ) 🌝"
        } else {
            typeLabel.text = "Type: \(mangas.type.capitalized ) 🌚"
        }
        if let volumes = manga?.volumes {
            volumesLabel.text = "Volumes: \(volumes) 📺"
        }
        volumesLabel.isHidden = manga?.volumes == nil
    }
    func backgroundSetup() {
        imageView.backgroundColor = .clear
        titleLabel.backgroundColor = .clear
        startLabel.backgroundColor = .clear
        endLabel.backgroundColor = .clear
        membersLabel.backgroundColor = .clear
        rankLabel.backgroundColor = .clear
        scoreLabel.backgroundColor = .clear
        volumesLabel.backgroundColor = .clear
        typeLabel.backgroundColor = .clear
        urlTextView.backgroundColor = .clear
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modallyScreenSegue" {
            let modallyVC = segue.destination as? ModallyScreenViewController
            modallyVC?.manga = manga?.imageUrl
            modallyVC?.url = manga?.url
        }
    }
    @IBAction func addToFavoritesAction(_ sender: UIButton) {
        _ = []
    }
}
