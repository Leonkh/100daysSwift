//
//  File.swift
//  MilestoneProjectsFrom10to12
//
//  Created by Леонид Хабибуллин on 06.11.2020.
//

import UIKit

class SavedImage: NSObject, Codable {
    
    var nameImage: String
    var caption: String = "There isn't caption"
    
    init(nameImage: String, caption: String){
        self.nameImage = nameImage
        self.caption = caption
    }
}
