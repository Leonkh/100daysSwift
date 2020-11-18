//
//  ViewController.swift
//  Project10
//
//  Created by Леонид Хабибуллин on 04.11.2020.
//
import LocalAuthentication
import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate { // That tells Swift you promise your class supports all the functionality required by the two protocols UIImagePickerControllerDelegate and UINavigationControllerDelegate. The first of those protocols is useful, telling us when the user either selected a picture or cancelled the picker. The second, UINavigationControllerDelegate, really is quite pointless here, so don't worry about it beyond just modifying your class declaration to include the protocol.
    
//    When you conform to the UIImagePickerControllerDelegate protocol, you don't need to add any methods because both are optional. But they aren't really – they are marked optional for whatever reason, but your code isn't much good unless you implement at least one of them!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default // Challenge 3 from project 28
        notificationCenter.addObserver(self, selector: #selector(hideAll), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(openAll), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
    }
    @objc func hideAll() { // Challenge 3 from project 28
        guard view.isHidden == false else {return}
        view.isHidden = true
        title = "You must pass authentication"
    }
    
    @objc func openAll() { // Challenge 3 from project 28
        guard view.isHidden == true else {return}
        let contex = LAContext() // объект LA. Error в LA это часть Obj-C, а не Swift
        var error: NSError?
        
        if contex.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            contex.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {[weak self] success, authencticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.view.isHidden = false
                        self?.title = ""
                    } else { 
                        let ac = UIAlertController(title: "Authentication failed", message: "You cann't be verified. Please, try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
            
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        present(ac, animated: true)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to deqeue Person cell")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image) //здесь получаем URL
        cell.imageView.image = UIImage(contentsOfFile: path.path) // UIImage(contentsOfFile:) читает путь как String, поэтому используем path.path что конвертировать URL в String
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3 //  закругление углов картинки
        cell.layer.cornerRadius = 7 // закругление углов ячейки
        
        return cell
    }
    @objc func addNewPerson() {
        let picker = UIImagePickerController() // специальный класс от Apple для импорта фотографий в приложение
        picker.allowsEditing = true // позволяет пользователю обрезать фото, которое он выбрал
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) == true { // Challenge 2
        picker.sourceType = .camera
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString // создаем случайное уникальное имя в формате String для фото
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName) // находим путь к нужному фото
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) { //переводим выбранное фото в формат jpeg с качеством сжатия 80%
            try? jpegData.write(to: imagePath) // записываем полученную jpeg на диск
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true) // закрываем окно
    }
    
    func getDocumentsDirectory() -> URL { //Again, it doesn't matter how getDocumentsDirectory() works, but if you're curious: the first parameter of FileManager.default.urls asks for the documents directory, and its second parameter adds that we want the path to be relative to the user's home directory. This returns an array that nearly always contains only one thing: the user's documents directory. So, we pull out the first element and return it.
        

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let change = UIAlertController(title: "Choose", message: "Do you wanr rename or delete this person?", preferredStyle: .alert) // Challenge 1
        
        change.addAction(UIAlertAction(title: "Rename", style: .default) { [weak self, weak change] _ in
        
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else {return}
            person.name = newName
            self?.collectionView.reloadData()
        })
        
        ac.addAction(UIAlertAction(title: "Cancle", style: .cancel))
            self?.present(ac, animated: true)
    }
        )
        change.addAction(UIAlertAction(title: "Delete", style: .default) { [weak self, weak change] _ in
            let ac = UIAlertController(title: "Delete person", message: "Are you sure", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self, weak ac] _ in
                self?.people.remove(at: indexPath.item)
                self?.collectionView.reloadData()
            })
                ac.addAction(UIAlertAction(title: "No", style: .cancel))
                self?.present(ac, animated: true)
        })
        present(change, animated: true) // Challenge 1
        
    }
    
    
}

