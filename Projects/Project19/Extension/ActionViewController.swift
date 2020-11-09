//
//  ActionViewController.swift
//  Extension
//
//  Created by Леонид Хабибуллин on 09.11.2020.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    var savedSites = [ScriptForSite]() // Challenge 2
    var usersScripts = [UserScript]() // Challenge 3

    @IBOutlet var script: UITextView!
    var pageTitle = ""
    var pageURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults() // Challenge 2
        if let dataToLoad = defaults.object(forKey: "savedSites") as? Data {
            do {
                let jsonDecoder = JSONDecoder()
                savedSites = try jsonDecoder.decode([ScriptForSite].self, from: dataToLoad)
            } catch {
                print("Failed to load data")
            }
        }
        
        let defaults2 = UserDefaults() // Challenge 3
        if let dataToLoad = defaults2.object(forKey: "usersScripts") as? Data {
            do {
                let jsonDecoder = JSONDecoder()
                usersScripts = try jsonDecoder.decode([UserScript].self, from: dataToLoad)
            } catch {
                print("Failed to load data")
            }
        }
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(choosePreScript)) // challenge 1
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil) // ремонт клавиатуры
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil) // ремонт клавиатуры
        
        
        
        
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem { // When our extension is created, its extensionContext lets us control how it interacts with the parent app. In the case of inputItems this will be an array of data the parent app is sending to our extension to use. We only care about this first item in this project, and even then it might not exist, so we conditionally typecast using if let and as?.
            if let itemProvider = inputItem.attachments?.first { // Our input item contains an array of attachments, which are given to us wrapped up as an NSItemProvider. Our code pulls out the first attachment from the first input item.
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { // The next line uses loadItem(forTypeIdentifier: ) to ask the item provider to actually provide us with its item, but you'll notice it uses a closure so this code executes asynchronously. That is, the method will carry on executing while the item provider is busy loading and sending us its data.
                    [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else {return}
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else {return}
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                        
                        for site in self!.savedSites {
                            if site.url == self!.pageURL {
                                self?.script.text = site.script
                            } else {
                                let page = ScriptForSite(url: (self?.pageURL)!, script: "") // Challenge 2
                                self?.savedSites.append(page) // Challenge 2
                                self?.save() // Challenge 2
                            }
                        }
                    }
                }
            }
        }
    }

    @IBAction func done() {  // обратное действие от viewDidLoad
        let item = NSExtensionItem()
        savedSites.last?.script = script.text // Challenge 2
        save() // Challenge 2
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    @objc func adjustForKeyboard(notification: Notification) { // починка клавы ОЧЕНЬ НУЖНАЯ ФУНКЦИЯ НА БУДУЩЕЕ
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero // script - это наше TextView поле
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    @objc func choosePreScript() { // challenge 1
        let ac = UIAlertController(title: "What you want", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Load saved scripts", style: .default, handler: {
            [weak self] _ in
            let list = UIAlertController(title: "Choose script", message: nil, preferredStyle: .actionSheet)
            for userScript in self!.usersScripts {
                list.addAction(UIAlertAction(title: userScript.name, style: .default, handler: { [weak self] _ in
                    self?.script.text = userScript.script
                }))
            }
            list.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(list, animated: true)
        }))
//        ac.addAction(UIAlertAction(title: "Title of site", style: .default, handler: {
//            [weak self] _ in
//            let text = "alert(document.title);"
//            self?.script.text = text
//        }))
        ac.addAction(UIAlertAction(title: "Save my script", style: .default, handler: {
            [weak self] _ in
            let name = UIAlertController(title: "Name of your script", message: nil, preferredStyle: .alert)
            name.addTextField()
            name.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                [weak self, weak ac] _ in
                if let nameOfScript = name.textFields?[0].text {
                    let newScript = UserScript(name: nameOfScript, script: self?.script.text ?? "There must be script")
                    self?.usersScripts.append(newScript)
                    self?.saveUserScript()
                }
            }))
            name.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(name, animated: true)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func save() { // Challenge 2
        let jsonEncoder = JSONEncoder()
        if let dataToSave = try? jsonEncoder.encode(savedSites) {
            let defaulats = UserDefaults()
            defaulats.set(dataToSave, forKey: "savedSites")
        } else {
            print("Failed to save data")
        }
    }
    func saveUserScript() { // Challenge 3
        let jsonEncoder = JSONEncoder()
        if let dataToSave = try? jsonEncoder.encode(usersScripts) {
            let defaulats = UserDefaults()
            defaulats.set(dataToSave, forKey: "usersScripts")
        } else {
            print("Failed to save data")
        }
    }
    

}
