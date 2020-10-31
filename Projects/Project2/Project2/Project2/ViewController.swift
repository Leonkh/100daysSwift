//
//  ViewController.swift
//  Project2
//
//  Created by Леонид Хабибуллин on 28.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    @IBOutlet var numberOfQuestion: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    var countries = [String]()
    
    var score = 0
    var questionNumber = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(lookScoreTapped))
        
        scoreLabel.text = "Your score is \(score)"
//        title = "Your score is \(score)"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
//        countries.append("estonia")
//        countries.append("france")
//        countries.append("germany")
//        countries.append("irland")
//        countries.append("italy")
//        countries.append("monaco")
//        countries.append("nigeria")
//        countries.append("poland")
//        countries.append("spain")
//        countries.append("uk")
//        countries.append("us")
        
        
        button1.layer.borderWidth = 1.5
        button2.layer.borderWidth = 1.5
        button3.layer.borderWidth = 1.5
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        if questionNumber == 10 {
            let af = UIAlertController(title: "End game!", message: "Your final score is \(score)", preferredStyle: .alert)
            af.addAction(UIAlertAction(title: "End", style: .default, handler: nil))
            
            present(af, animated: true)
        }
        questionNumber += 1
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        scoreLabel.text = "Your score is \(score)"
        numberOfQuestion.text = "This is \(questionNumber) question of 10"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
    
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    @objc func lookScoreTapped () {
        let sc = UIAlertController(title: "Your score", message: "\(score)", preferredStyle: .alert)
        sc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        sc.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        present(sc, animated: true)
    }
    
}

