//
//  CardsViewController.swift
//  chemistry
//
//  Created by Louis Debaere on 02/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var widthCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    let cellSide: CGFloat = 100.0
    
    var level: [CardModel] = []
    var isFlipped = false
    var lastFlippedIndex = -1
    var lastFlippedCell: CardCell?
    var indexOfOnlyFacedUpCard: Int?
    var matches = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start the level
        createLevel()
        
        widthCollectionView.constant = cellSide*4 + 20*3
        heightCollectionView.constant = cellSide*4 + 20*3
        
    }
    
    func createLevel () {
        level.removeAll()
        for element in DataManager.shared.makeElementArray(bundleURL: Bundle.main.bundleURL) {
            let id = element.id
            let firstCard = CardModel(id: id, image: element.name)
            let secondCard = CardModel(id: id, image: element.symbol)
            level.append(firstCard)
            level.append(secondCard)
        }
        level.shuffle()
    }
    
    // - MANAGER OF THE GAME
    
    func cardSelected(cell: CardCell, index: IndexPath) {
        
        // - the function enter in this if statement only when the user already touched a cell becouse "isFlipped" is true. The beginning of the game is at the end of the function, in the last "else" statement when "isFlipped" is not true.
        
        if isFlipped {
            
            if lastFlippedIndex != index.row {
                
                flipCardCell(cell: cell, image: level[index.row].image, completion: {(_) in
                    
                    // Cards Match succeeded ( first image = second image )
                    if self.level[self.lastFlippedIndex].element == self.level[index.row].element {
                        // Cards Match
                        print("POINT")
                        self.isFlipped = false
                        self.matches += 1
                        print(self.matches)
                        
                        if self.matches == 8 {
                            self.createLevel()
                            self.matches = 0
                            cell.isUserInteractionEnabled = true
                            for i in 0...15 {
                                self.collectionView.cellForItem(at: IndexPath(row: i, section: 0))?.isUserInteractionEnabled = true
                            }
                            self.collectionView.reloadData()
                            self.collectionView.reloadInputViews()
                            return
                        }
                        
                        // - disable the cells: the first touched and the second one
                        cell.isUserInteractionEnabled = false
                        self.lastFlippedCell?.isUserInteractionEnabled = false
                        
                        // - make them disappear
                        UIView.animate(withDuration: 1, animations: {
                            cell.alpha = 0.0
                            self.lastFlippedCell?.alpha = 0.0
                        })
                    }
                    else {
                        // Cards Match failed ( first image != second image )
                        print("WRONG")
                        self.isFlipped = false
                        // both the cards retrun to the starting position
                        // 1
                        self.flipCardCell(cell: cell, image: #imageLiteral(resourceName: "back"))
                        // 2
                        if let lastFlippedCell = self.lastFlippedCell {
                            self.flipCardCell(cell: lastFlippedCell, image: #imageLiteral(resourceName: "back"))
                        }
                    }
                })
                
            }
        }
            
            // - the game begins here, this else statement handles the first touch of the game
        else {
            lastFlippedIndex = index.row
            lastFlippedCell = cell
            isFlipped = true
            flipCardCell(cell: cell, image: level[index.row].image)
        }
    }
    
    // Handles the flipping animation revealing the new image
    func flipCardCell(cell: CardCell, image: UIImage, completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
            cell.cardImage.image = image
        }, completion: completion)
    }
    
}



extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return level.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSide, height: cellSide)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCell
        cell.cardImage.image = #imageLiteral(resourceName: "back")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell!
        cardSelected(cell: cell!, index: indexPath)
        
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

//   - this function return a random item from the storage

extension Array {
    func randomItem() -> (Int) {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return index
    }
}

extension Array {
    mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}





