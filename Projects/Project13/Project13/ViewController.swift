//
//  ViewController.swift
//  Project13
//
//  Created by Леонид Хабибуллин on 06.11.2020.
//

import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var intensity: UISlider!
    @IBOutlet var radius: UISlider!
    
    var currentImage: UIImage!
    
    @IBOutlet var changeFilterButton: UIButton!
    var contex: CIContext!
    var currentFilter: CIFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var str = ["Макароны", "Пюре", "Рис"]
//        str.shuffle()
//        print(str[0])
//
//        changeFilterButton.tit
        title = "Instafilter"
        contex = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        let names = ["CIBumpDistortion", "CIGaussianBlur", "CIPixellate", "CISepiaTone", "CITwirDistortion", "CIUnsharpMask", "CIVignette" ]
        for name in names {
            ac.addAction(UIAlertAction(title: name, style: .default, handler: { // Challenge 2
            [weak self] _ in
                sender.setTitle(name, for: .normal)
                let ac2 = UIAlertAction(title: name, style: .default)
                self?.setFilter(action: ac2)
            }))
        }

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popoverController =  ac.popoverPresentationController { // это для iPad
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
//        changeFilterButton.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
//        sender.setTitle("New title", for: .normal)
        present(ac, animated: true)
    }
    
    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        guard let actionTitle = action.title else { return }
        
        currentFilter = CIFilter(name: actionTitle)
//        changeFilterButton.setTitle(actionTitle, for: .normal)

        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    @IBAction func save(_ sender: Any) {
        if let image = imageView.image{
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        } else { // Challenge 1
            let ac = UIAlertController(title: "There no image to save", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        

        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
            
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radius.value * 200, forKey: kCIInputRadiusKey) // challenge 3
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {
            print("There no image")
            return
        }
        
        if let cgImage = contex.createCGImage(outputImage, from: outputImage.extent) {
            let processedImage = UIImage(cgImage: cgImage)
            imageView.image = processedImage
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
    
}

