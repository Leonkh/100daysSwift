//
//  ViewController.swift
//  MilestoneProjectsFrom19to21
//
//  Created by Леонид Хабибуллин on 12.11.2020.
//

import UIKit


var savedNotes = [Note]() // массив заметок

class ViewController: UITableViewController {
    
    var check = ["Проверка", "Массива"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("В savedNotesCheck элементов: \(savedNotesCheck.count)")
        title = "Заметки"
        let defaults = UserDefaults()
        if let dataToLoad = defaults.object(forKey: "savedNotes") as? Data {
            do {
                let jsonDecoder = JSONDecoder()
                savedNotes = try jsonDecoder.decode([Note].self, from: dataToLoad)
            } catch {
                print("Failed to load savedNotes")
            }
        }
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let symbol = UIImage(named: "note.text.badge.plus")
        let newNote = UIBarButtonItem(image: symbol, style: .plain, target: self, action: #selector(addNewNote))
        
        toolbarItems = [spacer, newNote]
        navigationController?.isToolbarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNotes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNote")
        if let description = savedNotes[indexPath.row].text {
            cell?.textLabel?.text = description
            cell?.textLabel?.adjustsFontForContentSizeCategory = true
//            cell?.textLabel?.textColor = .sy
            print("описание найдено")
        }
        cell?.backgroundColor = .none
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteView") as? NoteViewController {
            vc.noteView = savedNotes[indexPath.row]
//            print(savedNotes[indexPath.row].text)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(savedNotes) {
            let defaults = UserDefaults()
            defaults.setValue(savedData, forKey: "savedNotes")
//            print("savedNotes сохранен")
        } else {
            print("Failed to save savedNotes")
        }
        tableView.reloadData()
    }
    
    @objc func addNewNote() {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteView") as? NoteViewController {
//            print("NoteView найден")
            let note = Note(uniq: UUID().uuidString)
//            print("создан Note с именем \(note.uniq)")
            savedNotes.append(note)
//            print("Note добавлен в массив")
            vc.noteView = note
//            vc.notesView = savedNotes
//            print("Note отправлен в NoteView")
            save()
//            tableView.reloadData()
//            print("Элементов в массиве savedNotes: \(savedNotes.count)")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

