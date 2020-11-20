//
//  CollectionViewController.swift
//  MilestoneProjectsFrom28to30
//
//  Created by Леонид Хабибуллин on 20.11.2020.
//

import UIKit

//private let reuseIdentifier = "CardCell"

class CollectionViewController: UICollectionViewController {
    var cards = [String]()
    var opened = [Int]() // 0 - закрыта, 1 - открыта, 2 - убрана из игры
    
    var openedCard: String?
    var lastNumber: Int?
    var lastIndexPath: IndexPath?
    
    var score = 0
    var scoreToWin: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCard))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(goToOld))
        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        scoreToWin = cards.count / 2
        return cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else {fatalError("Cant find cell")}
        cell.textView.text = cards[indexPath.row]
        cell.imageView.image = UIImage(named: "cover")
        cell.textView.textAlignment = .center
        
        
        if opened[indexPath.row] == 1 {
            UIView.animate(withDuration: 1.5, delay: 1, animations: { [weak self] in
                cell.imageView.alpha = 0
            })
            UIView.animate(withDuration: 1.5, delay: 1, animations: { [weak self] in
                cell.textView.alpha = 1
            })
        } else if opened[indexPath.row] == 2 {
            UIView.animate(withDuration: 1.5, delay: 1, animations: { [weak self] in
                cell.imageView.alpha = 0
                cell.textView.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 1.5, delay: 1, animations: { [weak self] in
                cell.textView.alpha = 0
                cell.imageView.alpha = 1
            })
        }
        
        cell.sizeToFit()
        return cell
        
    }
    
    @objc func addCard() {
        let ac = UIAlertController(title: "Create new card", message: "Input text in card", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            [weak self] _ in
            if let text = ac.textFields?[0].text {
                self?.cards.append(text)
                self?.opened.append(0)
                self?.collectionView.reloadData()
                
            }
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func goToOld() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "OldVersion") as? ViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "What do you want?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Open card", style: .default, handler: {
            [weak self] _ in
            self?.opened[indexPath.row] = 1
            self?.collectionView.reloadItems(at: [indexPath])
            self?.checkMatch(indexPath: indexPath)
        }))
        ac.addAction(UIAlertAction(title: "Delete card", style: .default, handler: {
            [weak self] _ in
            self?.cards.remove(at: indexPath.row)
            self?.opened.remove(at: indexPath.row)
            self?.collectionView.reloadItems(at: [indexPath])
        }))
        present(ac, animated: true)
    }
    
    
        func checkMatch(indexPath: IndexPath) {
    
            let number = indexPath.row
//            let indexpathNow = indexPath
            
            guard let openedCardLast = openedCard else {
                openedCard = cards[number]
                lastNumber = number
                lastIndexPath = indexPath
                return}
    
            let currentCard = cards[number]
    
            if currentCard == openedCardLast {
//                UIView.animate(withDuration: 1.5, animations: { [weak self] in
                    opened[number] = 2
                    opened[lastNumber!] = 2
//                })
                openedCard = nil
                lastNumber = nil
                score += 1
                collectionView.reloadItems(at: [indexPath, lastIndexPath!])
            } else {
//                UIView.animate(withDuration: 1.5, animations: { [weak self] in
                    opened[number] = 0
                    opened[lastNumber!] = 0
//                })
                openedCard = nil
                lastNumber = nil
                collectionView.reloadItems(at: [indexPath, lastIndexPath!])
            }
            if score == scoreToWin {
                win()
            }
        }
    //
        func win() {
            let ac = UIAlertController(title: "You win!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start new game", style: .default, handler: {
                [weak self] _ in
                self?.newGame()
            }))
            present(ac, animated: true)
        }
    func newGame() {
        cards = cards.shuffled()
        for i in 0..<opened.count {
            opened[i] = 0
        }
        collectionView.reloadData()
    }
    
    
}
