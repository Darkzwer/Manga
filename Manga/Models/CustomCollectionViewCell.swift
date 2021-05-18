//
//  CustomCollectionViewCell.swift
//  Manga
//
//  Created by Igor on 09.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!//аутлет картинки
    @IBOutlet weak var nameLabel: UILabel!//аутлет текста
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}
