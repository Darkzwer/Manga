//
//  WebImageView.swift
//  Manga
//
//  Created by Igor on 17.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else {return}
        let dataTask = URLSession.shared.dataTask(with: url)
        
        }
    }
