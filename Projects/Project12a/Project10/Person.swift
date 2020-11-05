//
//  Person.swift
//  Project10
//
//  Created by Леонид Хабибуллин on 04.11.2020.
//

import UIKit

class Person: NSObject, NSCoding {

    var name: String
    var image: String
    
        init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) { // обязываем записать данные
        
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) { // метод считывания данных с диска
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
}
