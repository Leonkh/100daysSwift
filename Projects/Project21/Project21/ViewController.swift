//
//  ViewController.swift
//  Project21
//
//  Created by Леонид Хабибуллин on 10.11.2020.
//
import UserNotifications // импортируем framework для уведомлений
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current() // создаем объект. current значит к нынешней версии Notification Center, то есть на этот экран
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                print("Yay!")
            } else {
                print("D'oh!")
            }
        } // запрашиваем разрешение
    }
    
    @objc func scheduleLocal() {
        registerCategories() // инициилизируем категорию "alarm"
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() // отменяем отложенные уведомления - то есть, запланированные вами уведомления, которые еще не были доставлены, потому что их триггер не был встречен.
        
        let content = UNMutableNotificationContent()
        
        content.title = "Late wake up call" //  большой выделенный текст в уведомлении
        content.body = "The early bird catches the worm, but the second mouse gets the cheese." // основной текст в уведомлении
        content.categoryIdentifier = "alarm" // custom'ное действие, основанное на категории с индефикатором "alarm"
        content.userInfo = ["customData": "fizzbuzz"] // To attach custom data to the notification, e.g. an internal ID, use the userInfo dictionary property.
        content.sound = .default // default звук уведомления
        
        var dateComponents = DateComponents() // обект даты-времени
        dateComponents.hour = 10
        dateComponents.minute = 30
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) // создаем триггер уведомления основанный на времени. repeats = повторения
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // триггер который сработает через 5 секунд после его активации
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger) // создаем само уведомление-запрос
        
        center.add(request) // добавляем запрос в наш Notification Center
        
        
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self // любые уведомления будут относиться к нам
        
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground) // foreground означает - при нажатии на это уведомление открыть приложение, из которого пришло уведомление немедленно
        let reminder = UNNotificationAction(identifier: "reminde", title: "Remind me later", options: .foreground) // Challenge 2
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, reminder], intentIdentifiers: [], options: [])
        
        center.setNotificationCategories([category]) // задаем категорию "alarm"
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                let ac = UIAlertController(title: "You open it!", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true) // Challenge 1
            print("Default identifier")
            case "show":
                // пользователь нажал на кнопку "просмотреть больше информации"
            print("Show more information")
            case "reminde": // challenge 2
                scheduleLocal2()
            default:
                break
            }
            completionHandler() // говорим iOS что работа с уведомлением закончена
        }
    }
    func scheduleLocal2() { // Challnege 2
        registerCategories() // инициилизируем категорию "alarm"
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() // отменяем отложенные уведомления - то есть, запланированные вами уведомления, которые еще не были доставлены, потому что их триггер не был встречен.
        
        let content = UNMutableNotificationContent()
        
        content.title = "Late wake up call" //  большой выделенный текст в уведомлении
        content.body = "The early bird catches the worm, but the second mouse gets the cheese." // основной текст в уведомлении
        content.categoryIdentifier = "alarm" // custom'ное действие, основанное на категории с индефикатором "alarm"
        content.userInfo = ["customData": "fizzbuzz"] // To attach custom data to the notification, e.g. an internal ID, use the userInfo dictionary property.
        content.sound = .default // default звук уведомления
        
        var dateComponents = DateComponents() // обект даты-времени
        dateComponents.hour = 10
        dateComponents.minute = 30
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) // создаем триггер уведомления основанный на времени. repeats = повторения
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) // триггер который сработает через 5 секунд после его активации
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger) // создаем само уведомление-запрос
        
        center.add(request) // добавляем запрос в наш Notification Center
        
        
    }
}

