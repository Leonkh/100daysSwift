//
//  ViewController.swift
//  Project12
//
//  Created by Леонид Хабибуллин on 05.11.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard // Когда вы записываете данные в UserDefaults, они автоматически загружаются при запуске приложения, чтобы вы могли прочитать их снова. Это делает его использование действительно простым, но вы должны знать, что это плохая идея, чтобы хранить много данных там, потому что это будет замедлять загрузку вашего приложения. Если вы думаете, что ваши сохраненные данные займут больше, чем, скажем, 100 КБ, то UserDefaults - это почти наверняка неправильный выбор.
        
        
        defaults.set(25, forKey: "Age") // сохранять методом set можно любой тип данных. forKey должен быть уникальным
        
        defaults.setValue(true, forKey: "UserFaceID")
        
        let array = ["John", "Tigr", "Alex"]
        defaults.set(array, forKey: "savedArray") // сохраняем
        
        let savedInteger = defaults.integer(forKey: "Age")
        let savedBoolian = defaults.bool(forKey: "UserFaceID")
        
        let savedArray = defaults.object(forKey: "savedArray") as? [String] ?? [String]() // загружаем, если не удалось загрузить создаем пустой массив String
        
    }


}

