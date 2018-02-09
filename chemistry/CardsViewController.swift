//
//  CardsViewController.swift
//  chemistry
//
//  Created by Louis Debaere on 02/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    let backImage = #imageLiteral(resourceName: "back")
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var widthCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    var cellSide: CGFloat = 100
    
    var level: [CardModel] = []
    var isFlipped = false
    var lastFlippedIndex = -1
    var lastFlippedCell: CardCell?
    var indexOfOnlyFacedUpCard: Int?
    var matches = 0
    
    var iPadModel: String {
        let height = UIScreen.main.bounds.height
        if height == 768 {
            return "iPad"
        } else if height == 834 {
            return "iPad Pro 10.5"
        } else {
            return "iPad Pro 12.9"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch iPadModel {
        case "iPad":
            cellSide = 100
        case "iPad Pro 10.5":
            cellSide = 135
        default:
            cellSide = 155
        }
        
        
        // Start the level
        createLevel()
        
        widthCollectionView.constant = cellSide*6 + 20*5
        heightCollectionView.constant = cellSide*3 + 20*2
        
    }
    
    func createLevel() {
        level = DataManager.shared.makeElementArray(bundleURL: Bundle.main.bundleURL)
        level.shuffle()
    }
    
    func cardSelected(cell: CardCell, index: IndexPath) {
        
        // - the function enter in this if statement only when the user already touched a cell becouse "isFlipped" is true. The beginning of the game is at the end of the function, in the last "else" statement when "isFlipped" is not true.
        
        if isFlipped {
            

            if lastFlippedIndex != index.row {
                
                let currentCard = level[index.row]
                let lastFlippedCard = level[lastFlippedIndex]
                
                self.view.isUserInteractionEnabled = false
                
                UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                    cell.cardImage.image = currentCard.image
                }, completion: {(_) in
                    

                    if currentCard.element == lastFlippedCard.element {
                        print("Elements MATCH")
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
                        
                    } else {
                        print("Elements DO NOT MATCH")
                        self.isFlipped = false
                        UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                            usleep(500_000)
                            cell.cardImage.image = self.backImage
                        })
                        UIView.transition(with: self.lastFlippedCell!, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                            self.lastFlippedCell!.cardImage.image = self.backImage
                        })
                    }
                    self.view.isUserInteractionEnabled = true
                })
                
            }
        }
            
            // - the game begins here, this else statement handles the first touch of the game
        else {
            lastFlippedIndex = index.row
            lastFlippedCell = cell
            isFlipped = true
            UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                cell.cardImage.image = self.level[index.row].image
            })
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
        cell.cardImage.image = backImage
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





