//
//  ViewController.swift
//  Project7
//
//  Created by Леонид Хабибуллин on 02.11.2020.
//
// Grand Central Dispatch, or GCD - framework от Apple для использования многопоточности
// FIFO - first in - first out - это тип памяти "первый пришёл - первый ушёл"
// QoS - quality of service - приоритет обслуживания (выполнения) - 4 уровня: 1. User Interactive: это самый приоритетный фоновый поток, и он должен использоваться, когда вы хотите, чтобы фоновый поток выполнял работу, которая важна для поддержания работы пользовательского интерфейса. Этот приоритет попросит систему выделить почти все доступное процессорное время для вас, чтобы выполнить работу как можно быстрее. 2. User Initiated (Инициированный пользователем): это должно использоваться для выполнения задач, запрошенных пользователем, которых он сейчас ждет, чтобы продолжить использование вашего приложения. Это не так важно, как интерактивная работа пользователя - то есть, если пользователь нажимает на кнопки, чтобы сделать другие вещи, которые должны быть выполнены в первую очередь - но это важно, потому что вы заставляете пользователя ждать. 3. Utility queue: она должна использоваться для долгосрочных задач, о которых пользователь знает, но не обязательно сильно ожидает. Если пользователь что-то запросил и может с радостью оставить его запущенным, пока он делает что-то еще с вашим приложением, вы должны использовать Utility. 4. Background queue: это для долгосрочных задач, о которых пользователь не знает  или, по крайней мере, не заботится о их прогрессе или о том, когда они закончат работу.

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    
    var filteredPetitions = [Petition]()  // Challenge 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJSON), with: nil) // применить метод fetchJSON в потоке background
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(credits))  // Challenge 1
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFilter))  // Challenge 2
        
        let clear = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearFilter)) // Challenge 2
        
        toolbarItems = [clear] // Challenge 2
        navigationController?.isToolbarHidden = false // Challenge 2
        
//        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
//        let urlString: String
//
//        if navigationController?.tabBarItem.tag == 0 {
//           urlString = "https://hackingwithswift.com/samples/petitions-1.json" //вводим url объекта json
//        } else {
//            urlString = "https://hackingwithswift.com/samples/petitions-2.json"
//        }
//
//        DispatchQueue.global(qos: .userInitiated).async { // код ниже будет выполняться асинхронно ).async с другими, в том приоритете что указан в qos. Это background поток
//            [weak self] in // так как .async принимает только один параметр - закрытие - необходимо использовать  [weak self] in чтобы избежать strong reference cycles
//            if let url = URL(string: urlString){ // переводим формат string в url
//                if let data = try? Data(contentsOf: url) { // создаем объект класса Data с методом contentsOf, что вернёт нам данные с указанного url. Data(contentsOf:) - это blocking call, то есть он блокирует выполнение любого последующего кода в методе до тех пор, пока не подключится к серверу и полностью не загрузит все данные.
//                    self?.parse(json: data)
//                    return
//                }
//                }
//            self?.showError()
//        }
    }
 // There’s another way of using GCD, and it’s worth covering because it’s a great deal easier in some specific circumstances. It’s called performSelector(), and it has two interesting variants: performSelector(inBackground:) and performSelector(onMainThread:).
    
//    Both of them work the same way: you pass it the name of a method to run, and inBackground will run it on a background thread, and onMainThread will run it on a foreground thread. You don’t have to care about how it’s organized; GCD takes care of the whole thing for you. If you intend to run a whole method on either a background thread or the main thread, these two are easiest.
    
    @objc func fetchJSON() {
        
//        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
                
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://hackingwithswift.com/samples/petitions-1.json" //вводим url объекта json
        } else {
            urlString = "https://hackingwithswift.com/samples/petitions-2.json"
                }
        if let url = URL(string: urlString){ // переводим формат string в url
            if let data = try? Data(contentsOf: url) { // создаем объект класса Data с методом contentsOf, что вернёт нам данные с указанного url. Data(contentsOf:) - это blocking call, то есть он блокирует выполнение любого последующего кода в методе до тех пор, пока не подключится к серверу и полностью не загрузит все данные.
            parse(json: data)
            return
            }
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false) //  метод showError будет работать в main потоке
    }
    }
    
    @objc func addFilter() { // Challenge 2
        let ac = UIAlertController(title: "Enter filter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submit = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let filter = ac?.textFields?[0].text else {return}
            self?.submitToArray(filter: filter)
        }
        
        ac.addAction(submit)
        present(ac, animated: true)
    }
    
    func submitToArray(filter: String) { // Challenge 2
        
        for newElement in petitions {
            if newElement.body.contains(filter) || newElement.title.contains(filter) {
                filteredPetitions.append(newElement)
            }
        }
        tableView.reloadData()
//        filteredPetitions.removeAll()
    }
    
    @objc func credits() { // Challenge 1
        let ac = UIAlertController(title: "About this data", message: "The data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func clearFilter() {  // Challenge 2
        filteredPetitions.removeAll()
        tableView.reloadData()
        
        let ac = UIAlertController(title: "Filter was cleared", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func showError() {
//        DispatchQueue.main.async { [weak self] in // возвращаем функция в main поток
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredPetitions.isEmpty == true {
        return petitions.count
        } else {
            return filteredPetitions.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var petition = petitions[indexPath.row]
        
        if filteredPetitions.isEmpty == false {
            petition = filteredPetitions[indexPath.row]
        }
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

