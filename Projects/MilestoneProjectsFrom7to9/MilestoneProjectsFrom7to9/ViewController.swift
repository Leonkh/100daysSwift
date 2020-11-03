//
//  ViewController.swift
//  MilestoneProjectsFrom7to9
//
//  Created by Леонид Хабибуллин on 03.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLable: UILabel! // количество очков
    var nameGame: UILabel! // название игры
    var usedLetters = [String]() // массив использованных букв
    var lettersInWord = [String]() // массив букв в слове
    var score = 7 {
        didSet {
            scoreLable?.text = "Осталось попыток: \(score)"
        }
    }
    var printedLetters: UILabel! // поле, где показываются открытые и закрытые буквы
    var inputLetter:  UITextField! // поле для введения буквы
    var submit: UIButton! // кнопка отправить ответ
    var word: String = "" // загаданное слово
    var youSee = [String] () // то что отображается на экране в printedLetters
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLable = UILabel()
        scoreLable.translatesAutoresizingMaskIntoConstraints = false
        scoreLable.textAlignment = .right
        scoreLable.text = "Осталось попыток: \(score)"
        view.addSubview(scoreLable)
        
        nameGame = UILabel()
        nameGame.translatesAutoresizingMaskIntoConstraints = false
        nameGame.textAlignment = .center
        nameGame.font = UIFont.systemFont(ofSize: 40)
        nameGame.textColor = .systemRed
        nameGame.backgroundColor = .lightGray
        nameGame.text = "Игра: Висельница"
        nameGame.sizeToFit()
        view.addSubview(nameGame)
        
        printedLetters = UILabel()
        printedLetters.translatesAutoresizingMaskIntoConstraints = false
        printedLetters.textAlignment = .center
        printedLetters.font = UIFont.systemFont(ofSize: 46)
//        printedLetters.text = "Тут будет слово"
        printedLetters.numberOfLines = 0
//        printedLetters.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
//        printedLetters.setContentCompressionResistancePriority(UILayoutPriority(1), for: .vertical)
//        printedLetters.sizeToFit()
        printedLetters.backgroundColor = .lightGray
        view.addSubview(printedLetters)
        
        inputLetter = UITextField()
        inputLetter.translatesAutoresizingMaskIntoConstraints = false
        inputLetter.textAlignment = .center
        inputLetter.font = UIFont.systemFont(ofSize: 46)
        inputLetter.placeholder = "Введите букву"
        inputLetter.borderStyle = .bezel
        inputLetter.isUserInteractionEnabled = true
//        inputLetter.becomeFirstResponder()
        inputLetter.clearButtonMode = .whileEditing
        inputLetter.keyboardType = .default
        view.addSubview(inputLetter)
        
        submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("Ввести", for: .normal) // текст в кнопке для нормального состояния
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        submit.layer.borderWidth = 1.5
        submit.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(submit)
        
        
        
        
        NSLayoutConstraint.activate([
            scoreLable.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLable.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            
            nameGame.topAnchor.constraint(equalTo: scoreLable.bottomAnchor, constant: 20),
            nameGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameGame.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),

            printedLetters.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            printedLetters.bottomAnchor.constraint(equalTo: inputLetter.topAnchor, constant: -50),
            printedLetters.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),

            inputLetter.bottomAnchor.constraint(equalTo: submit.topAnchor, constant: -20),
            inputLetter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submit.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -200),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWord()

    }
    
    @objc func submitTapped(_ sender: UIButton) {
        guard let answerLetter = inputLetter.text?.lowercased() else { return }
        if answerLetter.count == 1 {
        if lettersInWord.contains(answerLetter.lowercased()) {
            if usedLetters.contains(answerLetter.lowercased()) == false {
                usedLetters.append(answerLetter.lowercased())
                
                var nums = [Int]()
                for i in 0..<lettersInWord.count {
                    if lettersInWord[i] == answerLetter {
                        nums.append(i+1)
                    }
                }
                youSee = replaceLetter(inArray: youSee, positions: nums, newLetter: answerLetter)
                checkWin()
                printedLetters.text = youSee.joined(separator: " ")
                printedLetters.sizeToFit()
                
            } else {
//                score -= 1
                let alertTitle = "Вы уже использовали эту букву"
                let alertMessage = "Попробуйте другую букву"
                showAlert(alertTitle: alertTitle, alertMessage: alertMessage)
//                checkDeath(score: score)
            }
                
        } else {
            score -= 1
            let alertTitle = "Этой буквы нет в слове"
            let alertMessage = "Попробуйте другую букву"
            showAlert(alertTitle: alertTitle, alertMessage: alertMessage)
            checkDeath(score: score)
        }
        } else {
            score -= 1
            let alertTitle = "Нельзя вводить больше одной буквы"
            let alertMessage = "Введите только одну букву"
            showAlert(alertTitle: alertTitle, alertMessage: alertMessage)
            checkDeath(score: score)
        }
        
        
    }
    
    @objc func loadWord() {
        score = 7
        if let wordsFileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordsContent = try? String(contentsOf: wordsFileURL) {
                var lines = wordsContent.components(separatedBy: "\n")
                lines.shuffle() // массив из слов
                word = lines[0]  // придали значение загадонному слову
//                print(word)
                
                for letter in word {
                    lettersInWord.append(String(letter))
                }
                
                print(lettersInWord)
//                youSee.removeAll()
                
                for _ in 0..<lettersInWord.count {
                    youSee.append("_")
                }
                printedLetters.text = youSee.joined(separator: " ")
                printedLetters.sizeToFit()
              
            }
        }
    }
    
    func replaceLetter(inArray: [String], positions: [Int], newLetter: String) -> [String] {
        var outArray = inArray
        for i in 0..<positions.count {
            let j = positions[i]
            outArray[j-1] = newLetter
                }
        return outArray
    }
    
    func showAlert(alertTitle: String, alertMessage: String, continueAlert: String = "Продолжить") {
        let ac = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: continueAlert, style: .default))
        present(ac, animated: true)
    }
    
    func checkDeath (score: Int) {
        if score == 0 {
            let alertTitle = "Вы проиграли"
            let alertMessage = "Вы не смогли разгадать слово \(word)!"
            let continueAlert = "Начать новую игру"
            
            showAlert(alertTitle: alertTitle, alertMessage: alertMessage, continueAlert: continueAlert)
            
            youSee.removeAll()
            usedLetters.removeAll()
            printedLetters.text?.removeAll()
            lettersInWord.removeAll()
            
            loadWord()
        }
    }
    
    func checkWin() {
        if youSee == lettersInWord {
            let alertTitle = "Вы выиграли"
            let alertMessage = "Вы смогли разгадать слово \(word)!"
            let continueAlert = "Начать новую игру"
            
            showAlert(alertTitle: alertTitle, alertMessage: alertMessage, continueAlert: continueAlert)
            
            youSee.removeAll()
            usedLetters.removeAll()
            printedLetters.text?.removeAll()
            lettersInWord.removeAll()
            
            loadWord()
        }
    }

}




// Код ниже возможно поможет с клавиатурой
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillShowNotification, object: nil)
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//                if self.view.frame.origin.y == 0 {
//                    self.view.frame.origin.y -= keyboardSize.height
//                }
//            }
//    }
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
