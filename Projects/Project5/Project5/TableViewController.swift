//
//  TableViewController.swift
//  Project5
//
//  Created by Леонид Хабибуллин on 01.11.2020.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    
    var savedData = [SavedData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let dataToLoad = defaults.object(forKey: "savedData") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                savedData = try jsonDecoder.decode([SavedData].self, from: dataToLoad)
            } catch {
                print("Failed to load")
            }
        }
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promtForAnswer)) // создаем кнопку, которая будет .add, что означает что она будет стандартным для iOS плюсиком и вызывает функцию promtForAnswer
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame)) // Challenge 3

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) // находим путь к файлу
            {
                allWords = startWords.components(separatedBy: "\n") // загружаем содержимое файла (по найденному пути формата URL) с разделителем в виде таба (\n)
            }
        }
        if allWords.isEmpty // можно использовать else, а можно еще allWords.count == 0, но allWords.isEmpty работает быстрее, потому что нет подсчета объектов
        {
            allWords = ["silkworm"]
        }
        startGame()
    }
        @objc func startGame() {
            if savedData.isEmpty { // Challenge 3 from Project 12
            title = allWords.randomElement() // выбираем случайное слово из массива как title
            
            usedWords.removeAll(keepingCapacity: true) // чистим массив слов введенных пользователем после предыдущей игры
            let savedWords = SavedData(currentWord: title!, inputedWords: usedWords)
            savedData.append(savedWords)
            save()
            tableView.reloadData() // перезагружаем все данные (ячейки) в таблице, игра начинается заново так что убираем всё после предыдушей игры
            } else {
                title = savedData.last?.currentWord
                usedWords = savedData.last!.inputedWords
            }
        }
        


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usedWords.count // вводим количество строчек в нашей таблице
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath) // определяем ячейку в строке таблицы
        cell.textLabel?.text = usedWords[indexPath.row] // заполняем ячейку текстом из массива usedWords по строчно
        return cell
    }
    
    @objc func promtForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert) // создаем всплывающее окно формата .alert
        ac.addTextField() // в это окно добавляем поле для ввода текста
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer.lowercased())
        } // вот тут сложно. Создаем closure (зыкрытие) submitAction типа UIAlertAction, которое в параметрах принимает себя и ac. Слово weak означает "слабую" связь - любые переменные или константы которые используются в closire Swift "захватывает", то есть как бы отдельно хранит в capture list. При сильной связи вы даже не сможете уничтожить объекты в  capture list. Однако, ключевое слово weak говорит о том, что объекты weak могут быть уничтожены или сведены к nil. Поэтому они всегда являются опционалами. Мы вызываем метод submit из ViewController. Для closure это внешний метод и он неявно требует захвата. Здесь это выражено с помощью self?. Мы как бы говорим Swift что понимаем что к submit может быть использован strong capture (self.) поэтому сам используем weak capture (self?)
        
        ac.addAction(submitAction) // добавляем всплывающему окну ac кнопку подтверждения
        present(ac, animated: true) // вызываем данное окно
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased() // переводим введённое слово в lowercase
        
        var errorTitle: String
        var errorMessage: String
        
        if isPossible(word: lowerAnswer) { // проверка на правильность слова
            if isOriginal(word: lowerAnswer) { // проверка на оригинальность (не было до)
                if isRealWord(word: lowerAnswer) { // проверка что это реально существующее слово
                    usedWords.insert(answer, at: 0) // добавляем слово в 0-ую позицию в массиве (самая верхняя строчка таблицы). Сначала добавляем в массив, а только потом добавляем строчку в таблицу чтоб была анимация
                    let savedWords = savedData.last
                    savedWords?.inputedWords = usedWords
                    save()
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic) //добавляем строчку на топ таблицы
                    
                    return
                } else {
                    errorTitle = "Word not recognise"
                    errorMessage = "You cant just make them up, you know!"
                    showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage) // Challenge 2
                }
            } else {
                errorTitle = "Word already used"
                errorMessage = "Be more original"
                showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage) // Challenge 2
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You cant spell this word from \(title!.lowercased())"
            showErrorMessage(errorTitle: errorTitle, errorMessage: errorMessage) // Challenge 2
        }
        
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { // раскрываем опционал (что слово реально написали)
            return false
        }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) { // чекаем что слово составленно из букв данного слова в title
                tempWord.remove(at: position) //убираем из изначального слова найденную букву
            } else {
                return false
            }
        }
        if word.lowercased() == title || word.utf16.count < 3 { //Chalenge 1
            return false
        }
        
        return true // если слово прошло оба цикло и не вернуло false значит оно прошло проверку
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word.lowercased()) // проверяем есть ли это слово в массиве уже использованных
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker() // создаем объект класса UITextChecker. Этот класс предназначен для выявления орфографических ошибок
        let range = NSRange(location: 0, length: word.utf16.count) // тип для хранения длины строки. location - начальная позиция. length - длина строки. От 0 до длины слова (word.utf16.count) и  будет длина всего слова. Тут используется utf16 потому что тип NSRange (как и весь UIKit) написан на objc, который хранит символы в utf16, а Swift utf8
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en") // непосредственно сам скан на орфографию: in: word - где искать, в переменной word, range:range - в каком диапазоне - по range (вся длина слова), language: "en" - на каком языке - на английском, startingAt: 0 - с какой позиции строки начать - с 0 (первая буква), wrap: false
        
        return misspelledRange.location == NSNotFound // NSNotFound говорит о том, что ошибок нет. .location обычно возвращает местоположение ошибки, но в случае с NSNotFound примет значение true
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) { //Chalenge 2
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let dataToSave = try? jsonEncoder.encode(savedData) {
            let defaults = UserDefaults.standard
            defaults.set(dataToSave, forKey: "savedData")
        } else {
            print("Failed to save")
        }
    }


}
