//
//  Times.swift
//  Project1
//
//  Created by Леонид Хабибуллин on 05.11.2020.
//

import UIKit

class ImageInfo: NSObject, Codable {
    var name: String
    var timesWasShown: Int
    
    init(name: String, timesWasShown: Int) {
        self.timesWasShown = timesWasShown
        self.name = name
    }
}
