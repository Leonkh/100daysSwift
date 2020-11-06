//
//  DetailViewController.swift
//  MilestoneProjectsFrom10to12
//
//  Created by Леонид Хабибуллин on 06.11.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
//    var selectedImage: String?
    var countOfPhoto: Int?
    var currentPhoto: Int?
    var detailSavedData = [SavedImage]()
    var titleOfImage: String = "" {
        didSet {
            title = titleOfImage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleOfImage = "This is \(currentPhoto!) photo from \(countOfPhoto!)"
//        let defaults = UserDefaults.standard
//        if let dataLoading = defaults.object(forKey: "detailSavedData") as? Data {
//            let jsonDecoder = JSONDecoder()
//            do {
//                detailSavedData = try jsonDecoder.decode([SavedImage].self, from: dataLoading)
//            } catch {
//                print("Failed to load detailData")
//            }
//        }
//        titleOfImage = detailSavedData.first!.nameImage
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editInfoImage))

        title = titleOfImage
        navigationItem.largeTitleDisplayMode = .never
        
        let imageToLoad = detailSavedData.first?.nameImage
        imageView.image = loadImage(imageToLoad!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
//    @objc func editInfoImage() {
//        let ac = UIAlertController(title: "Choose what to edit", message: nil, preferredStyle: .alert)
        
//        ac.addAction(UIAlertAction(title: "Name of image", style: .default, handler: { [weak self, weak ac] _ in
//            let ac2 = UIAlertController(title: "Input new name", message: nil, preferredStyle: .alert)
//            ac2.addTextField()
//            ac2.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac2] _ in
//                guard let newName = ac2?.textFields?[0].text else {return}
//                self?.detailSavedData.first?.nameImage = newName
//                self?.titleOfImage = (self?.detailSavedData.first!.nameImage)!
//                self?.save()
                
//                self?.view.reloadInputViews()
                
                
//            }))
//            self?.present(ac2, animated: true)
            
//        }))
//        ac.addAction(UIAlertAction(title: "Caption", style: .default, handler: {
//            [weak self, weak ac] _ in
//            let ac3 = UIAlertController(title: "Input new capyion", message: nil, preferredStyle: .alert)
//            ac3.addTextField()
//            ac3.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            ac3.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self, weak ac3] _ in
//                guard let newCaption = ac3?.textFields?[0].text else {return}
//                self?.detailSavedData.first?.caption = newCaption
//                self?.titleOfImage = (self?.detailSavedData.first!.caption)!
//                self?.save()
//                self?.view.reloadInputViews()
                
                
//            }))
//            self?.present(ac3, animated: true)
//
//        }))
//
//        present(ac, animated: true)
//    }
//    func save() {
//        let jsonEncoder = JSONEncoder()
//        if let savingData = try? jsonEncoder.encode(detailSavedData) {
//            let defaults = UserDefaults()
//            defaults.set(savingData, forKey: "detailSavedData")
//        } else {
//            print("Failed to save detailData")
//        }
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
