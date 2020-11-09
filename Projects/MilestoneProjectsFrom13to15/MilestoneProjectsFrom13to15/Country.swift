//
//  Country.swift
//  MilestoneProjectsFrom13to15
//
//  Created by Леонид Хабибуллин on 08.11.2020.
//

import UIKit

class Country: NSObject, Codable {
    var name: String
    var imageFlag: String
    var population: String = "Введите численность населения страны"
    var capital: String = "Введите столицу страны"
    
    init(name: String, imageFlag: String) {
        self.name = name
        self.imageFlag = imageFlag
    }
}
