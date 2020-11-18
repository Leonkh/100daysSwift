//
//  ViewController.swift
//  MilestoneProjectsFrom25to27
//
//  Created by Леонид Хабибуллин on 18.11.2020.
//
import CoreGraphics
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    var myImage: UIImage?
    var topText: String?
    var bottomText: String?
    
    var textAddFirst = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(share))
        
//        if let pic = myImage {
//            imageView.image = pic
//            imageView.sizeToFit()
//        }
    
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor)
        ])
        
//        renderMeme()
    }

    @objc func addPhoto() {
        
//        addText()
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 1) {
            try? jpegData.write(to: imagePath)
        }
        
        myImage = image
        viewDidLoad()
        
        dismiss(animated: true)
        
        addText()
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func addText() {
        let ac = UIAlertController(title: "Add top text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            [weak self] _ in
            if let text = ac.textFields?[0].text {
                self?.topText = text
            }
            self?.bottomTextAdd()
            
        }))
        ac.addAction(UIAlertAction(title: "Skip", style: .default, handler: {
            [weak self] _ in
//            self?.topText = "Top text skipped"
            self?.bottomTextAdd()
        }))
        present(ac, animated: true)
    }
    
    func bottomTextAdd() {
        let ac = UIAlertController(title: "Add bottom text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            [weak self] _ in
            if let text = ac.textFields?[0].text {
                self?.bottomText = text
            }
            self?.renderMeme()
        }))
        ac.addAction(UIAlertAction(title: "Skip", style: .default, handler: {
            [weak self] _ in
//            self?.bottomText = "Skip"
            self?.renderMeme()
        }))
        present(ac, animated: true)
    }
    
    
    func renderMeme() {
        guard let imageMem = myImage else {return}
        
        let renderer = UIGraphicsImageRenderer(size: imageMem.size)
        
        let img = renderer.image { ctx in
            let pic = imageMem
            pic.draw(at: CGPoint(x: 0, y: 0)) // Отрендерири картинку
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let size: CGFloat = 120
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: size),
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.red
                    ]
            
            let hh: CGFloat = size + 10
            if let topText = topText {
            let textOnTop = topText
            let attributedStringTop = NSAttributedString(string: textOnTop, attributes: attrs)
            let top: CGFloat = 0
//            let middle: CGFloat = 0    //imageMem.size.width / 2
            attributedStringTop.draw(with: CGRect(x: 0, y: top, width: imageMem.size.width, height: hh), options: .usesLineFragmentOrigin, context: nil)
            }
            if let bottomText = bottomText {
            let textOnBottom = bottomText
            let attributedStringBottom = NSAttributedString(string: textOnBottom, attributes: attrs)
            
            let bot: CGFloat = imageMem.size.height - hh
            print(imageMem.size.height)
            attributedStringBottom.draw(with: CGRect(x: 0, y: bot, width: imageMem.size.width, height: hh), options: .usesLineFragmentOrigin, context: nil)
            }
            
            
        }
        
        imageView.image = img
    
    }
    
    @objc func share() {
        guard let image = imageView.image?.jpegData(compressionQuality: 1) else {return}
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true)
    }

}

