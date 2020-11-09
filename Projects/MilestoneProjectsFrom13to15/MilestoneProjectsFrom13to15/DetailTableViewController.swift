//
//  DetailTableViewController.swift
//  MilestoneProjectsFrom13to15
//
//  Created by Леонид Хабибуллин on 09.11.2020.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var detailCountry = [Country]()
    var lastUsedCountry = [Country]()
    var array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults()
        if let dataToLoad = defaults.object(forKey: "detailCountry") as? Data {
            do {
                let jsonDecoder = JSONDecoder()
                lastUsedCountry = try jsonDecoder.decode([Country].self, from: dataToLoad)
            } catch {
                print("Failed to load data")
            }
        }
        
        if detailCountry.first?.imageFlag == lastUsedCountry.first?.imageFlag {
            detailCountry = lastUsedCountry
        }
        guard let name = detailCountry.first?.name else {return}
        guard let flag = detailCountry.first?.imageFlag else {return}
        guard let capital = detailCountry.first?.capital else {return}
        guard let population = detailCountry.first?.population else {return}
        
        array = [name, flag, capital, population]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        if let image: UIImage = loadImage(array[indexPath.row]) {
            cell.imageView?.image = image
            cell.textLabel?.text?.removeAll()
        }

        return cell
        }
    
    func save() {
        let defaults = UserDefaults()
//        let dataToSave = defaults.set(detailCountry, forKey: "detailCountry")
        let jsonEncoder = JSONEncoder()
        if let dataToSave = try? jsonEncoder.encode(detailCountry) {
            defaults.set(dataToSave, forKey: "detailCountry")
        } else {
            print("Failed to save")
        }
//        tableView.reloadData()
    }
    
    func loadImage(_ image1: String) -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(image1)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                return UIImage(data: try Data.init(contentsOf: fileURL))
            } catch {
                print("error getting image")
            }
        } else {
            print("No image in directory")
        }
        return UIImage(named: "")
    }
    
    @objc func edit() {
        let ac = UIAlertController(title: "Что хотите отредактировать?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Столицу", style: .default, handler: {
            [weak self] _ in
            let capitalChange = UIAlertController(title: "Введите назавание столицы", message: nil, preferredStyle: .alert)
            capitalChange.addTextField()
            capitalChange.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                [weak self] _ in
                if let newCapital = capitalChange.textFields?[0].text {
                    self?.detailCountry.first?.capital = newCapital
                    self?.save()
                    self?.array[2] = (self?.detailCountry.first!.capital)!
                    self?.tableView.reloadData()
                }
            }))
            capitalChange.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            self?.present(capitalChange, animated: true)
        }))
        
        ac.addAction(UIAlertAction(title: "Численность населения", style: .default, handler: {
            [weak self] _ in
            let popChange = UIAlertController(title: "Введите численность населения", message: nil, preferredStyle: .alert)
            popChange.addTextField()
            popChange.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                [weak self] _ in
                if let newPop = popChange.textFields?[0].text {
                    self?.detailCountry.first?.population = newPop
                    self?.save()
                    self?.array[3] = (self?.detailCountry.first!.population)!
                    self?.tableView.reloadData()
                }
            }))
            popChange.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            self?.present(popChange, animated: true)
        }))
        
        ac.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(ac, animated: true)
    }

}
