//
//  gamerScore.swift
//  Project2
//
//  Created by Леонид Хабибуллин on 05.11.2020.
//

import UIKit

class GamerScore: NSObject, Codable {
    
    var score: Int
//    var name: String
    
    init(score: Int) {
        self.score = score
//        self.name = name
    }
}
