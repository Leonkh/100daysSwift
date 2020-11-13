//
//  Note.swift
//  MilestoneProjectsFrom19to21
//
//  Created by Леонид Хабибуллин on 12.11.2020.
//

import UIKit

class Note: NSObject, Codable {
    
    var uniq: String
//    var name = "Новая заметка"
    
    var text: String?
    
    init(uniq: String) {
        self.uniq = uniq
    }
    
}
