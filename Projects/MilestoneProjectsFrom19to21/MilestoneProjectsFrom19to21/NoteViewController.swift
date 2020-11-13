//
//  NoteView.swift
//  MilestoneProjectsFrom19to21
//
//  Created by Леонид Хабибуллин on 12.11.2020.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textNote: UITextView!
    var noteView: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let shareImage = UIImage(named: "square.and.arrow.up")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage, style: .plain, target: self, action: #selector(share))
        let bin = UIImage(named: "xmark.bin.circle.fill")
        title = ""
        let delete = UIBarButtonItem(image: bin, style: .plain, target: self, action: #selector(deleteNote))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let symbol = UIImage(named: "note.text.badge.plus")
        let newNote = UIBarButtonItem(image: symbol, style: .plain, target: self, action: #selector(addNewNote))
        toolbarItems = [delete,spacer,newNote]
        navigationController?.isToolbarHidden = false
        
        if let nvc = storyboard?.instantiateViewController(withIdentifier: "Table") as? ViewController {
            print("В NoteViewController до каких либо действий в check элементов: \(nvc.check.count)")
            print("В NoteViewController до каких либо действий в savedNotes элементов: \(savedNotes.count)")
        }
        
        
        
        
//        print("Функция count в NoteViewController до каких либо действий в savedNotes элементов: \(nvc.count()) ")
        textNote.delegate = self
        print(noteView.uniq)

    textNote.text = noteView.text
        
        let notificationCenter = NotificationCenter.default
               notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil) // ремонт клавиатуры
               notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil) // ремонт клавиатуры
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        noteView.text = textNote.text
        saveNote()
    }
    func saveNote() {
//        print("Ввелась буква \(textNote.text) в textNote и вызвался сейв")
        if let nvc = storyboard?.instantiateViewController(withIdentifier: "Table") as? ViewController {
//            print("Table ViewController найден")
//            print(nvc.check[0],nvc.check.count)
            print("Кол-во элементов в savedNotes \(savedNotes.count)")
//            print("Кол-во элементов в notesView \(notesView.count)")
            for notes: Note in savedNotes {
                print("Зашёл в цикл")
                if notes.uniq == noteView.uniq {
                    notes.text = noteView.text
                    nvc.save()
//                    nvc.tableView.reloadData()
                    print("Данные заметки обновленны")
                }
            }
        } else {
            print("Table ViewController не найден")
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) { // починка клавы ОЧЕНЬ НУЖНАЯ ФУНКЦИЯ НА БУДУЩЕЕ
            guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
            
            let keyboardScreenEndFrame = keyboardValue.cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            
            if notification.name == UIResponder.keyboardWillHideNotification {
                textNote.contentInset = .zero // script - это наше TextView поле
            } else {
                textNote.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
            }
        textNote.scrollIndicatorInsets = textNote.contentInset
            
            let selectedRange = textNote.selectedRange
        textNote.scrollRangeToVisible(selectedRange)
        }
    
    @objc func deleteNote() {
        for (index,notes) in savedNotes.enumerated() {
            if notes.uniq == noteView.uniq {
                savedNotes.remove(at: index)
            }
        }
        if let nnn = storyboard?.instantiateViewController(withIdentifier: "Table") as? ViewController {
            nnn.save()
        }
        navigationController?.popViewController(animated: true) // вернуться в предыдущий vc
    }
    
    @objc func addNewNote() {

            if let nnn = storyboard?.instantiateViewController(withIdentifier: "Table") as? ViewController {
//                navigationController?.popViewController(animated: false) // вернуться в предыдущий vc
                let note = Note(uniq: UUID().uuidString)
    //            print("создан Note с именем \(note.uniq)")
                savedNotes.append(note)
                nnn.save()
                noteView = note
                viewDidLoad()
            }
    }
    
    @objc func share() {
        let sh = UIActivityViewController(activityItems: [noteView.text], applicationActivities: [])
        sh.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(sh, animated: true)
    }

}
