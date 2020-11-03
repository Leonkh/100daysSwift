//
//  ViewController.swift
//  Project7
//
//  Created by Леонид Хабибуллин on 02.11.2020.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    
    var filteredPetitions = [Petition]()  // Challenge 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(credits))  // Challenge 1
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFilter))  // Challenge 2
        
        let clear = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearFilter)) // Challenge 2
        
        toolbarItems = [clear] // Challenge 2
        navigationController?.isToolbarHidden = false // Challenge 2
        
//        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        let urlString: String
            
        if navigationController?.tabBarItem.tag == 0 {
           urlString = "https://hackingwithswift.com/samples/petitions-1.json" //вводим url объекта json
        } else {
            urlString = "https://hackingwithswift.com/samples/petitions-2.json"
        }
          
        
        if let url = URL(string: urlString){ // переводим формат string в url
            if let data = try? Data(contentsOf: url) { // создаем объект класса Data с методом contentsOf, что вернёт нам данные с указанного url
                parse(json: data)
                return
            }
            }
        showError()
    }
    
    @objc func addFilter() { // Challenge 2
        let ac = UIAlertController(title: "Enter filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submit = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let filter = ac?.textFields?[0].text else {return}
            self?.submitToArray(filter: filter)
        }
        
        ac.addAction(submit)
        present(ac, animated: true)
    }
    
    func submitToArray(filter: String) { // Challenge 2
        DispatchQueue.global(qos: .background).async { [weak self] in // Challenge 3 from project9
            for newElement in (self?.petitions)! {
                if newElement.body.contains(filter) || newElement.title.contains(filter) {
                    self?.filteredPetitions.append(newElement)
                }
            }
            DispatchQueue.main.async { [weak self] in // Challenge 3 from project9
                self?.tableView.reloadData()
            }

        }
        

//        filteredPetitions.removeAll()
    }
    
    @objc func credits() { // Challenge 1
        let ac = UIAlertController(title: "About this data", message: "The data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func clearFilter() {  // Challenge 2
        filteredPetitions.removeAll()
        tableView.reloadData()
        
        let ac = UIAlertController(title: "Filter was cleared", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredPetitions.isEmpty == true {
        return petitions.count
        } else {
            return filteredPetitions.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var petition = petitions[indexPath.row]
        
        if filteredPetitions.isEmpty == false {
            petition = filteredPetitions[indexPath.row]
        }
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

