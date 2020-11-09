//
//  ViewController.swift
//  MilestoneProjectsFrom13to15
//
//  Created by Леонид Хабибуллин on 08.11.2020.
//

import UIKit

class ViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults()
        if let dataToLoad = defaults.object(forKey: "countries") as? Data {
            do {
                let jsonDecoder = JSONDecoder()
                countries = try jsonDecoder.decode([Country].self, from: dataToLoad)
            } catch {
                print("Failed to load data")
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCountry))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadCells))
        // Do any additional setup after loading the view.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.image = loadImage(countries[indexPath.row].imageFlag)
        
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ac = UIAlertController(title: "Выберите действие", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Переименовать страну", style: .default, handler: {
            [weak self] _ in
            let rename = UIAlertController(title: "Введите название страны", message: nil, preferredStyle: .alert)
            rename.addTextField()
            rename.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                [weak self] _ in
                if let newName = rename.textFields?[0].text {
                    self?.countries[indexPath.row].name = newName
                    self?.save()
                    self?.tableView.reloadData()
                }
            }))
            rename.addAction(UIAlertAction(title: "Отмена", style: .cancel))
            self?.present(rename, animated: true)
        }))
        ac.addAction((UIAlertAction(title: "Перейти в профиль страны", style: .default, handler: {
            [weak self] _ in
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailTableViewController {
                vc.detailCountry.removeAll()
                vc.detailCountry.append((self?.countries[indexPath.row])!)
                
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        })))
        ac.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(ac, animated: true)

    }
    
    
    
    
    @objc func addNewCountry() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let country = Country(name: "Название страны", imageFlag: imageName)
        countries.append(country)
        save()
        tableView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let dataToSave = try? jsonEncoder.encode(countries) {
            let defaults = UserDefaults()
            defaults.set(dataToSave, forKey: "countries")
        } else {
            print("Failed to save data")
        }
    }
    
//    func changeName(country: Country) {
//
//        let ac = UIAlertController(title: "Введите название страны", message: nil, preferredStyle: .alert)
//        ac.addTextField()
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//
//        if let name = ac.textFields?[0].text {
//            country.name = name
//            save()
//            tableView.reloadData()
//        }
//    }
//
//    @objc func reloadCells() {
//        tableView.reloadData()
//    }
    
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
    

}

