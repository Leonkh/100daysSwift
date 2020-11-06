//
//  TableViewController.swift
//  MilestoneProjectsFrom10to12
//
//  Created by Леонид Хабибуллин on 06.11.2020.
//

import UIKit

class TableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var savedData = [SavedImage]()
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let savedImage = defaults.object(forKey: "savedData") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                savedData = try jsonDecoder.decode([SavedImage].self, from: savedImage)
            } catch {
                print ("Failed to load")
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedData.count
    }
    


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
        cell.imageView?.image = loadImage(savedData[indexPath.row].nameImage)
        cell.textLabel?.text = savedData[indexPath.row].caption

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let image = savedData[indexPath.row]
        
        let ac = UIAlertController(title: "What do you want?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Change caption", style: .default, handler: {
            [weak self, weak ac] _ in
            let ac2 = UIAlertController(title: "Input new caption", message: nil, preferredStyle: .alert)
            ac2.addTextField()
            ac2.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                [weak self, weak ac2] _ in
                guard let newCaption = ac2?.textFields?[0].text else {return}
                self?.savedData[indexPath.row].caption = newCaption
//                self?.titleOfImage = (self?.detailSavedData.first!.nameImage)!
                self?.save()
                self?.tableView.reloadData()
            }))
            self?.present(ac2, animated: true)
        }))
        ac.addAction(UIAlertAction(title: "Choose this photo", style: .default, handler: {
            [weak self, weak ac] _ in
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                vc.detailSavedData.removeAll()
                vc.detailSavedData.append((self?.savedData[indexPath.row])!)
                vc.countOfPhoto = self?.savedData.count
                vc.currentPhoto = indexPath.row + 1
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }))
        present(ac, animated: true)
    }
    @objc func addNewPhoto() {
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
        
        let savedImage = SavedImage(nameImage: imageName, caption: "There isn't caption")
        savedData.append(savedImage)
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
        if let savedImages = try? jsonEncoder.encode(savedData) {
            let defaults = UserDefaults.standard
            defaults.set(savedImages, forKey: "savedData")
        } else {
            print("Failed to save")
        }
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
}
