//
//  SavedData.swift
//  Project5
//
//  Created by Леонид Хабибуллин on 05.11.2020.
//

import UIKit

class SavedData: NSObject, Codable {
    
    var currentWord: String
    var inputedWords = [String]()
    
    init(currentWord: String, inputedWords: [String]) {
        self.currentWord = currentWord
        self.inputedWords = inputedWords
    }
}
