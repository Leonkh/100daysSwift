//
//  ViewController.swift
//  Project18
//
//  Created by Леонид Хабибуллин on 09.11.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        print("I'm inside viewDidLoad() method.")
//        print(1, 2, 3, 4, 5, separator: "-")
//        print("Some message", terminator: "")
        
//        assert(myReallySlowMethod() == true,"The slow method returned false, which is a bad thing!")
        
        for i in 1...100 {
            print("Got number \(i).")
        }
    }


}

