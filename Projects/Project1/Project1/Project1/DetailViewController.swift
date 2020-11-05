//
//  DetailViewController.swift
//  Project1
//
//  Created by Леонид Хабибуллин on 27.10.2020.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
//    var timesWasShown = 0 {
//        didSet {
//            title = "Picture \(selectedPictureNumber + 1) of \(totalPictures), was shown \(timesWasShown)"
//        }
//    }
//    var imageInfo = [ImageInfo]()
    
    var selectedPictureNumber: Int = 0
    var totalPictures: Int = 0

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let defaults = UserDefaults.standard
//        if let savedInfo = defaults.object(forKey: "imageInfo") as? Data {
//            let jsonDecoder = JSONDecoder()
//            do {
//                imageInfo = try jsonDecoder.decode([ImageInfo].self, from: savedInfo)
//            } catch {
//                print("Failled to load")
//            }
//        }
        
//        title = selectedImage
//        timesWasShown = imageInfo[0].timesWasShown
        title = "Picture \(selectedPictureNumber + 1) of \(totalPictures)"
        
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
//            imageView.image = "Picture of \(pictures.count)"
            imageView.image = UIImage(named: imageToLoad)
//            timesWasShown += 1
//            saveInfoImage(name: imageToLoad, timesWasShown: timesWasShown)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
//    func saveInfoImage(name: String, timesWasShown: Int) {
//        let infoImage = ImageInfo(name: name, timesWasShown: timesWasShown)
//        imageInfo.append(infoImage)
//        save()
//    }
//
//    func save() {
//        let jsonEncoder = JSONEncoder()
//        if let saveData = try? jsonEncoder.encode(imageInfo) {
//            let defaults = UserDefaults.standard
//            defaults.set(saveData, forKey: "imageInfo")
//        } else {
//            print("Failed to save")
//        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
