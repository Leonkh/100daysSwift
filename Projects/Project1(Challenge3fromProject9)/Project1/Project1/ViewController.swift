//
//  ViewController.swift
//  Project1
//
//  Created by Леонид Хабибуллин on 27.10.2020.
//

import UIKit


class ViewController: UICollectionViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pictures = [Image]()
    var startPictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
//        title = "Leon's Viewer"
//        navigationController?.navigationBar.prefersLargeTitles = true
//
        DispatchQueue.global(qos: .background).async { [weak self] in // Challenge 1 из проекта 9
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)

            for item in items {
                if item.hasSuffix("jpg") {
                    self?.startPictures.append(item)
                }
                self?.startPictures.sort()
            }
            
            for i in 0..<self!.startPictures.count {
                let item = Image(name: self!.startPictures[i], image: self!.startPictures[i])
                self!.pictures.append(item)
            }
            self?.reloadData()
        }
//
//
//
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? ImageCell else {fatalError("Unable to deqeue ImageCell")}
        
        let image = pictures[indexPath.item]
        cell.nameImage.text = image.name
        
        let path = getDocumentsDirectory().appendingPathComponent((image.image)) //здесь получаем URL
        if (UIImage(named: image.name) != nil) {
            cell.imageView.image = UIImage(named: image.name)} else {
                cell.imageView.image = UIImage(contentsOfFile: path.path)
            }
//        cell.imageView.image = UIImage(contentsOfFile: path.path) // UIImage(contentsOfFile:) читает путь как String, поэтому используем path.path что конвертировать URL в String
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3 //  закругление углов картинки
        cell.layer.cornerRadius = 7 // закругление углов ячейки
        
        return cell
    }
    
    @objc func addNewImage() {
        let picker = UIImagePickerController() // специальный класс от Apple для импорта фотографий в приложение
        picker.allowsEditing = true // позволяет пользователю обрезать фото, которое он выбрал
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) == true { // Challenge 2
        picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let picture = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString // создаем случайное уникальное имя в формате String для фото
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName) // находим путь к нужному фото
        
        if let jpegData = picture.jpegData(compressionQuality: 0.8) { //переводим выбранное фото в формат jpeg с качеством сжатия 80%
            try? jpegData.write(to: imagePath) // записываем полученную jpeg на диск
        }
        
        let image = Image(name: "Unknown", image: imageName)
        pictures.append(image)
        collectionView.reloadData()
        
        dismiss(animated: true) // закрываем окно
    }
    
    func getDocumentsDirectory() -> URL { //Again, it doesn't matter how getDocumentsDirectory() works, but if you're curious: the first parameter of FileManager.default.urls asks for the documents directory, and its second parameter adds that we want the path to be relative to the user's home directory. This returns an array that nearly always contains only one thing: the user's documents directory. So, we pull out the first element and return it.
        

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = pictures[indexPath.item]
        
        let change = UIAlertController(title: "Choose", message: "Do you wanr rename or delete this image?", preferredStyle: .alert) // Challenge 1
        
        change.addAction(UIAlertAction(title: "Rename", style: .default) { [weak self, weak change] _ in
        
        let ac = UIAlertController(title: "Rename image", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else {return}
            image.name = newName
            self?.collectionView.reloadData()
        })
        
        ac.addAction(UIAlertAction(title: "Cancle", style: .cancel))
            self?.present(ac, animated: true)
    }
        )
        change.addAction(UIAlertAction(title: "Delete", style: .default) { [weak self, weak change] _ in
            let ac = UIAlertController(title: "Delete image", message: "Are you sure", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self, weak ac] _ in
                self?.pictures.remove(at: indexPath.item)
                self?.collectionView.reloadData()
            })
                ac.addAction(UIAlertAction(title: "No", style: .cancel))
                self?.present(ac, animated: true)
        })
        present(change, animated: true) // Challenge 1
        
    }
//
    func reloadData() { // Challenge 1 из проекта 9
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pictures.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
//        cell.textLabel?.text = pictures[indexPath.row]
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            vc.selectedImage = pictures[indexPath.row]
//            vc.selectedPictureNumber = indexPath.row
//            vc.totalPictures = pictures.count
//
//
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//
    @objc func shareTapped() {
        let please = "Please, recomend this app for your friends: URL"
        let vc = UIActivityViewController(activityItems: [please], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
//
