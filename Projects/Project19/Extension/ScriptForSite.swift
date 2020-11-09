//
//  ScriptForSite.swift
//  Extension
//
//  Created by Леонид Хабибуллин on 09.11.2020.
//

import UIKit

class ScriptForSite: NSObject, Codable {
    
    var url: String
    var script: String
    
    init(url: String, script: String) {
        self.url = url
        self.script = script
    }
}
