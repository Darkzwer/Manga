//
//  CustomCollectionViewswift
//  Manga
//
//  Created by Igor on 09.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    var url = ""
    private let imageService = ImageService()
    private var data = [Manga]()
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSetup()
    }
    // MARK: - CellSet
    func apply(_ model: Manga) {
        url = model.imageUrl
        let urlString = model.imageUrl
        imageService.downloadImage(urlString: urlString) { [weak self] (result) in
            switch result {
            case .success(let image):
                if self?.url == model.imageUrl {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(named: "1")
                }
            }
        }
        nameLabel.text = model.title.capitalized
    }
    // MARK: - ImageSetup
    func imageSetup() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.contentMode = .scaleAspectFill
    }
}
