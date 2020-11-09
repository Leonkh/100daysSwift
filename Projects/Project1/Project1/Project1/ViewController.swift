//
//  ViewController.swift
//  Project1
//
//  Created by Леонид Хабибуллин on 27.10.2020.
//

import UIKit


class ViewController: UITableViewController {
    var pictures = [String]()
    
    var imageInfo = [ImageInfo]() // Challenge 1 from Project 12
    var times: Int = 0 // Challenge 1 from Project 12
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard // Challenge 1 from Project 12
                if let savedInfo = defaults.object(forKey: "imageInfo") as? Data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        imageInfo = try jsonDecoder.decode([ImageInfo].self, from: savedInfo)
                    } catch {
                        print("Failled to load")
                    }
                }
//        times = 0
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        title = "Leon's Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        DispatchQueue.global(qos: .background).async { [weak self] in // Challenge 1 из проекта 9
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasSuffix("jpg") {
                    self?.pictures.append(item)
                }
                self?.pictures.sort()
            }
            self?.reloadData()
        }
        
 
    }
    
    func reloadData() { // Challenge 1 из проекта 9
        DispatchQueue.main.async { [weak self] in
            
            self?.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for i in 0..<pictures.count {
            let image = ImageInfo(name: (pictures[i]), timesWasShown: 0)
            imageInfo.append(image)
            save()
        }
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
       
        
//        saveInfoImage(name: pictures[indexPath.row], timesWasShown: times)
//        save()
//        tableView.reloadData()
        
//        cell.textLabel?.text = "\(pictures[indexPath.row]) was'n shown yet"
        
//        try? cell.textLabel?.text = "\(pictures[indexPath.row]) was shown \(imageInfo[indexPath.row].timesWasShown)"
        
        cell.textLabel?.text = """
\(pictures[indexPath.row])
It was shown \(imageInfo[indexPath.row].timesWasShown) times
"""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Bad") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPictureNumber = indexPath.row
            vc.totalPictures = pictures.count
            
//            times = imageInfo[indexPath.row].timesWasShown + 1
            imageInfo[indexPath.row].timesWasShown += 1
//            let image = ImageInfo(name: pictures[indexPath.row], timesWasShown: times)
//            saveInfoImage(name: pictures[indexPath.row], timesWasShown: times)
            save()
            tableView.reloadData()
            navigationController?.pushViewController(vc, animated: true)
           
           
        }
    }
    
    @objc func shareTapped() {
        let please = "Please, recomend this app for your friends: URL"
        let vc = UIActivityViewController(activityItems: [please], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
//    func saveInfoImage(name: String, timesWasShown: Int) { // Challenge 1 from Project 12
//            let infoImage = ImageInfo(name: name, timesWasShown: timesWasShown)
//            imageInfo.append(infoImage)
//            save()
//        }
    
        func save() { // Challenge 1 from Project 12
            let jsonEncoder = JSONEncoder()
            if let saveData = try? jsonEncoder.encode(imageInfo) {
                let defaults = UserDefaults.standard
                defaults.set(saveData, forKey: "imageInfo")
            } else {
                print("Failed to save")
            }
}
}
