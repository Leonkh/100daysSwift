//
//  ViewController.swift
//  Project28
//
//  Created by Леонид Хабибуллин on 18.11.2020.
//
import LocalAuthentication // импортируем framework для работы с Touch или Face ID
import UIKit

class ViewController: UIViewController {

    @IBOutlet var secret: UITextView!
    var firstVisit = true
    var password: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if firstVisit {
            createPass()
        }
        title = "Nothing to see here"
        
        let doneButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveSecretMessage)) // challenge 1
        navigationItem.rightBarButtonItem = doneButton // challenge 1
        navigationController?.isNavigationBarHidden = true // challenge 1
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil) // как только окно приложения перестаёт быть активным, вызывается метод saveSecretMessage
    }
    
    func unlockMessage() {
        secret.isHidden = false // отображаем textView
        navigationController?.isNavigationBarHidden = false // challenge 1
        title = "Secret staff"
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? "" // подгружаем текст
    }
    
   @objc func saveSecretMessage() {
        guard secret.isHidden == false else {return} // проверяем что textView отображается
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage") // сохраняем текст в шифрованном виде
        secret.resignFirstResponder() // textView становится неактивным на экране
        secret.isHidden = true
        navigationController?.isNavigationBarHidden = true
        title = "Nothing to see here"
    }
    

    @IBAction func authencticateTapped(_ sender: Any) {
        let contex = LAContext() // объект LA. Error в LA это часть Obj-C, а не Swift
        var error: NSError?
        
        if contex.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) { // проверяем можем ли мы использовать биометрические данные для индификации, если нет, то ошибка записывается в error. Тут obj-c.
            let reason = "Identify yourself!" // покажется только для Touch ID. Причина для Face ID записывается в info
            
            contex.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {[weak self] success, authencticationError in
                DispatchQueue.main.async { // запрашиваем разрешение и далее trailing syntax с закрытием, где рассматриваем варианты
                    if success { // обязательно в главном потоке, ведь это часть UI
                        self?.unlockMessage()
                    } else { // если что то пошло не так при идентификации
                        let ac = UIAlertController(title: "Authentication failed", message: "You cann't be verified. Please, try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
            
        } else { // Challenge 2
//            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            present(ac, animated: true)
            let ac = UIAlertController(title: "Input a pass", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                if let pass = ac.textFields?[0].text {
                    guard pass == KeychainWrapper.standard.string(forKey: "Password") else { return }
                    self?.unlockMessage()
                }
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }
        
        
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) { // метод для решения проблем с клавиатурой
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEnd = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEnd.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
        
    }
    
    func createPass() { // Challenge 2
        let ac = UIAlertController(title: "Make a password for this app", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Skip", style: .default))
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let newPass = ac.textFields?[0].text else {return}
            self?.password = newPass
            self?.firstVisit = false
            KeychainWrapper.standard.set(self!.password!, forKey: "Password")
        }))
        present(ac, animated: true)
    }
    
}

