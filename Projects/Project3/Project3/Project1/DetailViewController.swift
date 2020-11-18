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
    
    var selectedPictureNumber: Int = 0
    var totalPictures: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        //        title = selectedImage
        title = "Picture \(selectedPictureNumber + 1) of \(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never

//        if let imageToLoad = selectedImage {
////            imageView.image = "Picture of \(pictures.count)"
//            imageView.image = UIImage(named: imageToLoad)
//        }
        drawImage()
        
        
    }
    func drawImage() { // challenge 3 from project27
        guard let selectedImage = selectedImage else {return}
        print("Картинка найдена")
        let img1 = UIImage(named: selectedImage)
        let size = img1!.size
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let img = renderer.image { ctx in
            let picture = img1
            let width = size.width
            let height = size.height
            picture?.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
                    ]
            let text = "From Storm Viewer"
            let attributedString = NSAttributedString(string: text, attributes: attrs)

            attributedString.draw(with: CGRect(x: 0, y: 50, width: width, height: 36), options: .usesLineFragmentOrigin, context: nil) //  рисуем в конкретной области
            
            
            
             
        }
        imageView.image = img
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
