//
//  ViewController.swift
//  MilestoneProjectsFrom28to30
//
//  Created by Леонид Хабибуллин on 19.11.2020.
//
import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    @IBOutlet var imageView4: UIImageView!
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    
    var imageViewArray = [UIImageView]()
    var buttonArray = [UIButton]()
    var openedCard: UIImageView?
    var lastNumber: Int?
    
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(hideAll), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(openAll), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        let cover = UIImage(named: "cover")
        imageViewArray.append(imageView1)
        imageViewArray.append(imageView2)
        imageViewArray.append(imageView3)
        imageViewArray.append(imageView4)
        
        buttonArray.append(button1)
        buttonArray.append(button2)
        buttonArray.append(button3)
        buttonArray.append(button4)
        
        for imageView in imageViewArray {
            imageView.alpha = 0
        }
        
        for button in buttonArray {
            button.setTitle(nil, for: .normal)
            button.setImage(cover, for: .normal)
            button.alpha = 1
        }
        
        newGame()
    }
    
    func newGame() {
        score = 0
        var appleCounts = 0
        
        for imageView in imageViewArray.shuffled() {
            if appleCounts != 2 {
                imageView.image = UIImage(named: "apple")!
                appleCounts += 1
            } else {
                imageView.image = UIImage(named: "orange")!
            }
        }
        for button in buttonArray {
            button.alpha = 1
        }
    }
    
    @IBAction func buuton1Tapped(_ sender: Any) {
        let name = "1"
        openCard(name: name)
    }
    
    @IBAction func button2Tapped(_ sender: Any) {
        let name = "2"
        openCard(name: name)
    }
    
    
    @IBAction func button3Tapped(_ sender: Any) {
        let name = "3"
        openCard(name: name)
    }
    
    @IBAction func button4Tapped(_ sender: Any) {
        let name = "4"
        openCard(name: name)
    }
    
    func openCard(name: String) {
        UIView.animate(withDuration: 1.5, animations: { [weak self] in
            for button in self!.buttonArray {
                if button.restorationIdentifier == "buttonCard\(name)" {
                    
                    button.alpha = 0
                }
            }
        })
        UIView.animate(withDuration: 1.5, delay: 1, animations: { [weak self] in
            for imageView in self!.imageViewArray {
                if imageView.restorationIdentifier == "card\(name)" {
                    imageView.alpha = 1
                    
                }
            }
        })
        checkMatch(name: name)
        
    }
    func checkMatch(name: String) {
        
        guard var number = Int(name) else {return}
        number -= 1
        guard let openedCardLast = openedCard else {
            openedCard = imageViewArray[number]
            lastNumber = number
            return}
        
        let currentImage = imageViewArray[number]
        
        if currentImage.image == openedCardLast.image {
            UIView.animate(withDuration: 1.5, animations: { [weak self] in
                self!.imageViewArray[number].alpha = 0
                self!.imageViewArray[self!.lastNumber!].alpha = 0
            })
            openedCard = nil
            lastNumber = nil
            score += 1
        } else {
            UIView.animate(withDuration: 1.5, animations: { [weak self] in
                self!.imageViewArray[number].alpha = 0
                self!.imageViewArray[self!.lastNumber!].alpha = 0
            })
            UIView.animate(withDuration: 1.5, delay: 0.75, animations: { [weak self] in
                self!.buttonArray[number].alpha = 1
                self!.buttonArray[self!.lastNumber!].alpha = 1
            })
            openedCard = nil
            lastNumber = nil
        }
        if score == 2 {
            win()
        }
    }
    
    func win() {
        let ac = UIAlertController(title: "You win!", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Start new game", style: .default, handler: {
            [weak self] _ in
            self?.newGame()
        }))
        present(ac, animated: true)
    }
    
    @objc func hideAll() {
        guard view.isHidden == false else {return}
        view.isHidden = true
        title = "You show pass identification"
    }
    
    @objc func openAll() {
        guard view.isHidden == true else {return}
        let contex = LAContext()
        var error: NSError?
        
        if contex.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            contex.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authencticationError in
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
    
    
}
