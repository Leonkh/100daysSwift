//
//  TableViewController.swift
//  Project4
//
//  Created by Леонид Хабибуллин on 30.10.2020.
//

import UIKit

class TableViewController: UITableViewController {

    var websites2 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websites2 += ["hackingwithswift.com", "apple.com", "google.com", "yandex.ru"]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(websites2.count)
        return websites2.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell", for: indexPath)
        cell.textLabel?.text = websites2[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.selectedWebsite = websites2[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
