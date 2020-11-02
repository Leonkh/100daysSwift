//
//  ViewController.swift
//  Project6b
//
//  Created by Леонид Хабибуллин on 01.11.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let label1 = UILabel( ) // создаем объект статичного текста на экране
        label1.translatesAutoresizingMaskIntoConstraints = false // отключает автоматическое определние ограничений (constraints). Имеются ввиду ограничения в интерфейсе (как в Auto Layout). Мы их зададим сами
        label1.backgroundColor = .red // цвет бэкграунда надписи
        label1.text = "THESE" // текст надписи
        label1.sizeToFit() // размер ячейки текста подстраивается под текст внутри
        
        let label2 = UILabel( )
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
    
        let label3 = UILabel( )
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel( )
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel( )
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1) // вызываем показ наших labels на экране
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
    
//        let viewsDictionary = ["label1": label1,
//                               "label2": label2,
//                               "label3": label3,
//                               "label4": label4,
//                               "label5": label5] // создаем словарь с нашими labels
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary)) // view - это основное поле (белое после запуска приложения), addConstraints - добавляем ограничения, NSLayoutConstraint.constraints - метод Auto Layout который создает ограничения из языка Visual Format Language (VFL), по заданным параметрам: views - для каких элементов, "H:|[\label]|" - H - horizontal layout - горизонтальная ориентация, | - граница. So, "H:|[label1]|" means "horizontally, I want my label1 to go edge to edge in my view." But there's a hiccup: what is "label1"? Sure, we know what it is because it's the name of our variable, but variable names are just things for humans to read and write – the variable names aren't actually saved and used when the program runs. This is where our viewsDictionary dictionary comes in: we used strings for the key and UILabels for the value, then set "label1" to be our label. This dictionary gets passed in along with the VFL, and gets used by iOS to look up the names from the VFL. So when it sees [label1], it looks in our dictionary for the "label1" key and uses its value to generate the Auto Layout constraints.
//
//        }
//
//        let metrics = ["labelHeight": 88]
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary)) // Constraint priority is a value between 1 and 1000, where 1000 means "this is absolutely required" and anything less is optional. By default, all constraints you have are priority 1000, so Auto Layout will fail to find a solution in our current layout. But if we make the height optional – even as high as priority 999 – it means Auto Layout can find a solution to our layout: shrink the labels to make them fit.
//
//    }
        var previous: UILabel?
        
//        var heightOfLabels = CGFloat(view.safeAreaLayoutGuide.heightAnchor * 0.25 - 10) // Challeng3 3
        
//        var heightOfLabels = CGFloat(88)
        
        for label in [label1, label2, label3, label4, label5] {
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true //Challenge 1 and 2
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true // Challenge 1 and 2
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1, constant: 50).isActive = true // Challenge 3
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            previous = label
        }
}
}

