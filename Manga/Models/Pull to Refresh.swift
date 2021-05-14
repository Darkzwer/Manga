//
//  Pull to Refresh.swift
//  Manga
//
//  Created by Igor on 13.05.2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UITableViewController {
    
    var tableViewElements = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        let elementIndex = tableViewElements.count
        tableViewElements.append("Element \(elementIndex)")
        sender.endRefreshing()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewElements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let element = tableViewElements[indexPath.row]
        
        cell.textLabel?.text = element
        
        return cell
    }
    
    
}
