//
//  UserScript.swift
//  Extension
//
//  Created by Леонид Хабибуллин on 09.11.2020.
//

import UIKit

class UserScript: NSObject, Codable {
    
    var name: String
    var script: String
    
    init(name: String, script: String) {
        self.name = name
        self.script = script
    }
}
