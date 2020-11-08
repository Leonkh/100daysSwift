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
    
    var players = [GamerScore]()
    
    var score = 0
    var questionNumber = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard // Challenge 2 from Project 12
        if let savedData = defaults.object(forKey: "players") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                players = try jsonDecoder.decode([GamerScore].self, from: savedData)
            } catch {
                print("Failed to load data")
            }
        }
        let player = GamerScore(score: score)
        players.append(player)
        
        
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
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 4, options: [], animations: { // Challenge 3 from Project 15
            sender.transform = CGAffineTransform(scaleX: 0.55, y: 0.55)
            sender.transform = .identity
        })
        
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
//            showNext(title: title)
            if score > (players.last?.score)! {
                newScore()
                showNext(title: title)
            }
            showNext(title: title)
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
            
            score -= 1
            showNext(title: title)
        }
        
//        showNext(title: title)
    }
    
    @objc func lookScoreTapped () {
        let sc = UIAlertController(title: "Your score", message: "\(score)", preferredStyle: .alert)
        sc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        sc.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        present(sc, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(players) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "players")
        } else {
            print("Failed to save")
        }
    }
    
    func newScore() {
        let gamer = GamerScore(score: score)
        players.removeAll()
        players.append(gamer)
        save()
        let ac = UIAlertController(title: "It's new score!", message: "You beated the previous high score ", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: {_ in self.showNext(title: "Correct!")}))
        present(ac, animated: true)
//        return
        
//        showNext(title: "Correct!")
    }
    
    
    func showNext(title: String){
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
    
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
}

