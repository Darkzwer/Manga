//
//  OldViewController.swift
//  Manga
//
//  Created by Igor on 11.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

//struct Hero: Decodable {//indian struct
//    let localized_name: String//name
//    let img: String//image
//}
//
//class ViewController: UIViewController, UICollectionViewDataSource {
//    
//    var HeroInfo = [Hero]()
//    
//    @IBOutlet weak var collectionView: UICollectionView!//collection view outlet
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        collectionView.dataSource = self
// 
//        let urlString = "https://api.opendota.com/api/heroStats"//api link
//        guard let url = URL(string: urlString) else { return }//or use ! on url! parametr
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if error == nil { //or if let error = error
//                do {
//                    self.HeroInfo = try JSONDecoder().decode([Hero].self, from: data!)
//                } catch {
//                    print("Parse Error")
//                }
//                DispatchQueue.main.async {//асинхронное добавление загрузки данных для избежаний зависания приложения во время загрузки
//                    self.collectionView.reloadData()
//                }
//            }
//        }.resume()//или запрос не будет обработан
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return HeroInfo.count//count of heroes
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
//        
//        cell.nameLabel.text = HeroInfo[indexPath.row].localized_name.capitalized//check this string
//        
//        let defaultLink = ("https://api.opendota.com")//image link part
//        let completeLink = defaultLink + HeroInfo[indexPath.row].img//image link full
//        
//        cell.imageView.downloaded(from: completeLink)//image link
//        cell.imageView.clipsToBounds = true//imageView из аутлета текста в CustomCollectionViewCell
//        cell.imageView.layer.cornerRadius = cell.imageView.frame.height / 2
//        cell.imageView.contentMode = .scaleAspectFill
//        return cell
//    }
//}
